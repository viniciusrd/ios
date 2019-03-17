//
//  PlacesFinderViewController.swift
//  QueroConhecer
//
//  Created by Vinicius Rodrigues on 16/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
import MapKit

protocol PlaceFinderDelegate: class {
    func addPlace(_ place: Place)
}

class PlacesFinderViewController: UIViewController {
    
    enum PlaceFinderMessageType {
        case error(String)
        case confirmation(String)
    }

    @IBOutlet weak var tfPlace: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var viLoading: UIView!
    
    var place : Place!
    weak var delegate: PlaceFinderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //configurando gestos no mapview
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(getLocation(_:)))
        gesture.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewPopup.layer.cornerRadius = 10;
        viewPopup.layer.masksToBounds = true;
    }
    
    
    //Usando selector devemos expor a function para objetive-c
    @objc func getLocation(_ gesture: UILongPressGestureRecognizer)  {
        
        if gesture.state == .began{
            showLoad(show: true)
            let point = gesture.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                 self.validateLocation(error, placemarks)
            }
        }
    }
    
    fileprivate func validateLocation(_ error: Error?, _ placemarks: [CLPlacemark]?) {
        self.showLoad(show: false)
        if error == nil{
            if !self.savePlace(with: placemarks?.first){
                self.showMessage(type: .error("Nenhum local encontado."))
            }
        }else{
            self.showMessage(type: .error("Erro Desconhecido"))
        }
    }
    
    @IBAction func findPlace(_ sender: UIButton) {
        
        tfPlace.resignFirstResponder()
        let address = tfPlace.text!
        showLoad(show: true)
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            self.validateLocation(error, placemarks)
        }
        
    }
    
    func savePlace(with placemark: CLPlacemark?) -> Bool {
        guard let placemark = placemark , let coodinate = placemark.location?.coordinate else{
            return false
        }
        let name = placemark.name ?? placemark.country ?? "Desconhecido"
        let address = Place.getFormattedAddress(with: placemark)
        place  = Place(name: name, latitude: coodinate.latitude, longitude: coodinate.longitude, address: address)
        let region = MKCoordinateRegion(center: coodinate,latitudinalMeters: 3500,longitudinalMeters: 3500)
        mapView.setRegion(region, animated: true)
        self.showMessage(type: .confirmation(place.name))

        return true
    }
    
    func showMessage(type: PlaceFinderMessageType){
        let title: String, message: String
        var hasConfirmation: Bool = false
        
        switch type {
        case .confirmation(let name):
            title = "Local Encontrado"
            message = "Deseja adicionar \(name)?"
            hasConfirmation = true
        case .error(let errorMessage):
            title = "Erro"
            message = errorMessage
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        if hasConfirmation{
            let confirmAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                self.delegate?.addPlace(self.place)
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(confirmAction)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func showLoad(show: Bool) {
        viLoading.isHidden = !show
        if show{
            aiLoading.startAnimating()
        }else{
            aiLoading.stopAnimating()
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
