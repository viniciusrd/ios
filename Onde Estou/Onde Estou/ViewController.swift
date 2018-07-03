//
//  ViewController.swift
//  Onde Estou
//
//  Created by Vinícius Rodrigues Duarte on 01/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    var locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last!;
        let latitude = userLocation.coordinate.latitude;
        let longitude = userLocation.coordinate.longitude;
        
        self.longitudeLabel.text = String( longitude );
        self.latitudeLabel.text = String( latitude );
        
        if userLocation.speed > 0 {
            self.speedLabel.text = String( userLocation.speed );
        }
        
        let deltaLat: CLLocationDegrees = 0.01;
        let deltaLon: CLLocationDegrees = 0.01;
        
        let areaShow: MKCoordinateSpan = MKCoordinateSpanMake(deltaLat, deltaLon);
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude);
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, areaShow)
        self.map.setRegion(region, animated: true);
        
        //recuperar o endereco
        CLGeocoder().reverseGeocodeLocation(userLocation) { (locationDetails, erro) in
            if erro == nil {
            
                if let dadosLocal = locationDetails?.first{
                    var thoroughfare = "";
                    if dadosLocal.thoroughfare != nil{
                        thoroughfare = dadosLocal.thoroughfare!;
                    }
                    
                    var subThoroughfare = "";
                    if dadosLocal.thoroughfare != nil{
                        subThoroughfare = dadosLocal.subThoroughfare!;
                    }
                    
                    var locality = "";
                    if dadosLocal.locality != nil{
                        locality = dadosLocal.locality!;
                    }
                    
                    var subLocality = "";
                    if dadosLocal.subLocality != nil{
                        subLocality = dadosLocal.subLocality!;
                    }
                    
                    var postalCode = "";
                    if dadosLocal.postalCode != nil{
                        postalCode = dadosLocal.postalCode!;
                    }
                    
                    var country = "";
                    if dadosLocal.country != nil{
                        country = dadosLocal.country!;
                    }
                    
                    var adminArea = "";
                    if dadosLocal.administrativeArea != nil{
                        adminArea = dadosLocal.administrativeArea!;
                    }
                    
                    var subAdminArea = "";
                    if dadosLocal.subAdministrativeArea != nil{
                        subAdminArea = dadosLocal.subAdministrativeArea!;
                    }
     
                    self.adressLabel.text = "\n Rua " + thoroughfare + ", "+subThoroughfare +
                                       "\n Bairro: " + subLocality  + ", Cidade " + locality +
                                       "\n Estado:"  + adminArea    +
                                       "\n CEP: "    + postalCode   + ", " + country;
                    
                }
                
            }else{
                print(erro);
            }
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse{
            
            let alertController = UIAlertController(
                title: "Permissão para localização",
                message: "Para o funcionamento correto deste app é nescessário a permissão de sua localização, por favor habilite.",
                preferredStyle: .alert
            );
            
            // terceito parametro eh uma closure.
            let configAction = UIAlertAction(
                title: "Abrir Configurações",
                style: .default) { (alertConfig) in
                    if let config = NSURL(string: UIApplicationOpenSettingsURLString){
                        UIApplication.shared.open(config as URL);
                    }
            };
            
            let cancelAction = UIAlertAction(
                title: "Cancelar",
                style: .default,
                handler: nil
            );
            
            alertController.addAction(configAction);
            alertController.addAction(cancelAction);
            
            //present(alertController,true,nil);
            
            present(alertController, animated: true, completion: nil);
            
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

