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
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viInfo: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    // MARK: - Properties
    var places: [Place]!
    var pointsOfInterest: [MKAnnotation] = []
    var btnUserLocation: MKUserTrackingButton!
    var selectedAnnotation: PlaceAnnotation?
    
    lazy var locationManaget = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManaget.delegate = self
        searchBar.isHidden = true
        viInfo.isHidden = true
        
        configureLocationButton()
        
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
    
    func showInfo()  {
        lbName.text = selectedAnnotation?.title ?? "Not Found"
        lbAddress.text = selectedAnnotation?.address ?? "Not Found"
        viInfo.isHidden = false
    }
    
    @IBAction func showRoute(_ sender: UIButton) {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse{
            showMessage(type: .authorizationWarning)
            return
        }
        
        let request = MKDirections.Request()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: selectedAnnotation!.coordinate))
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: locationManaget.location!.coordinate))
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            if error == nil, let response = response{
                self.mapView.removeOverlays(self.mapView.overlays)
                let route = response.routes.first!
                print("Name: \(route.name)")
                print("Distance: \(route.distance)")
                print("Duration: \(route.expectedTravelTime)")
                print("######################################")
                
                for step in route.steps{
                    print("Em \(step.distance) metros(s), \(step.instructions)")
                }
                
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                var annotations = self.mapView.annotations.filter({!($0 is PlaceAnnotation)})
                annotations.append(self.selectedAnnotation!)
                self.mapView.showAnnotations(annotations, animated: true)
                
                
            }else{
                self.showMessage(type: .routeError)
            }
        }
        
        
    }
    
    
    @IBAction func showSearchBar(_ sender: Any) {
        searchBar.resignFirstResponder()
        searchBar.isHidden = !searchBar.isHidden
    }
    
    func showMessage(type: MapMessageType){
        let title = type == .authorizationWarning ? "Aviso" : "Erro"
        let message = type == .authorizationWarning ? "Para usar os recursos de localização do App, você precisa permitir o uso na tela de Ajustes" : "Não foi possível encontrar esta rota"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        if type == .authorizationWarning{
            let confirmAction = UIAlertAction(title: "Ir para ajustes", style: .default) { (UIAlertAction) in
                
                if let appSetting = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(appSetting, options: [:], completionHandler: nil)
                }
            }
            alert.addAction(confirmAction)
        }
        present(alert, animated: true, completion: nil)
    }
    
}
// MARK: - Extensions
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let camera = MKMapCamera()
        camera.centerCoordinate = (view.annotation!.coordinate)
        camera.pitch = 80
        camera.altitude = 100
        mapView.setCamera(camera, animated: true)
    
        selectedAnnotation = (view.annotation as! PlaceAnnotation)
        showInfo()
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline{
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor(named: "Main")?.withAlphaComponent(0.8)
            renderer.lineWidth = 5.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
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
//        if let location = locations.last{
//            print("Velocidade: \(location.speed)")
//            let region = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: 500,longitudinalMeters: 500)
//            mapView.setRegion(region, animated: true)
//        }
    }
}
