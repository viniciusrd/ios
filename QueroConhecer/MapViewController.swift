//
//  MapViewController.swift
//  QueroConhecer
//
//  Created by Vinicius Rodrigues on 16/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    enum MapMessageType {
        case routeError
        case authorizationWarning
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viInfo: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var places: [Place]!
    var pointsOfInterest: [MKAnnotation] = []
    var btnUserLocation: MKUserTrackingButton!
    
    lazy var locationManaget = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManaget.delegate = self
        searchBar.isHidden = true
        viInfo.isHidden = true
        
        if places.count == 1{
            title = places[0].name
        }else{
            title = "Meus Lugares"
        }
    
        for place in places {
            addToMap(place)
        }
        showPlaces()
        requestUserLocationAuthorization()
    }
    
    func configureLocationButton()  {
        btnUserLocation = MKUserTrackingButton(mapView: mapView)
        btnUserLocation.backgroundColor = .white
        btnUserLocation.frame.origin.x = 10
        btnUserLocation.frame.origin.y = 10
        
        btnUserLocation.layer.cornerRadius = 5
        btnUserLocation.layer.borderWidth = 1
        btnUserLocation.layer.borderColor = UIColor(named: "Main")?.cgColor
        btnUserLocation.layer.cornerRadius = 5
        
        
    }
    
    func requestUserLocationAuthorization(){
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus(){
            case .notDetermined: locationManaget.requestWhenInUseAuthorization()
            case .restricted: break
            case .denied: showMessage(type: .authorizationWarning)
            case .authorizedWhenInUse , .authorizedAlways:
                mapView.addSubview(btnUserLocation!)
            }
        }else{
            //nao dá
        }
    }
    
    func addToMap(_ place: Place)  {
        
        let annotation = PlaceAnnotation(coordinate: place.coordinate, type: .place)
        annotation.coordinate = place.coordinate
        annotation.title = place.name
        mapView.addAnnotation(annotation)
        
    }
    
    func showPlaces()  {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }

    @IBAction func showRoute(_ sender: UIButton) {
        
    }
    
    
    @IBAction func showSearchBar(_ sender: Any) {
        searchBar.resignFirstResponder()
        searchBar.isHidden = !searchBar.isHidden
    }
    
    func showMessage(type: MapMessageType){
//        let title: String, message: String
//        var hasConfirmation: Bool = false
//
//        switch type {
//        case .confirmation(let name):
//            title = "Local Encontrado"
//            message = "Deseja adicionar \(name)?"
//            hasConfirmation = true
//        case .error(let errorMessage):
//            title = "Erro"
//            message = errorMessage
//        }
    }
    
}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is PlaceAnnotation){
            return nil
        }
        let type = (annotation as! PlaceAnnotation).type
        let identifier = "\(type)"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil{
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView?.annotation = annotation
        annotationView?.canShowCallout = true
        annotationView?.markerTintColor = type == .place ? UIColor(named: "Main") : UIColor(named: "poi")
        annotationView?.glyphImage = type == .place ? UIImage(named: "placeGlyph") : UIImage(named: "poiGlyph")
        annotationView?.displayPriority = type == .place ? .required : .defaultHigh
        
        return annotationView
    }
}

extension  MapViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isHidden = true
        searchBar.resignFirstResponder()
        loading.startAnimating()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBar.text
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if error == nil{
                guard let response = response else {
                    self.loading.stopAnimating()
                    return
                }
                self.mapView.removeAnnotations(self.pointsOfInterest)
                self.pointsOfInterest.removeAll()
                for item in response.mapItems{
                    let annotation = PlaceAnnotation(coordinate: item.placemark.coordinate, type: .pointOfInterest)
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    annotation.address = Place.getFormattedAddress(with: item.placemark)
                    self.pointsOfInterest.append(annotation)
                }
                self.mapView.addAnnotations(self.pointsOfInterest)
                self.mapView.showAnnotations(self.pointsOfInterest, animated: true)
            }
            self.loading.stopAnimating()
        }
    }
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            mapView.showsUserLocation = true
            mapView.addSubview(btnUserLocation!)
            locationManaget.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.last!)
    }
}
