//
//  ViewController.swift
//  PokemonGO Simple Clone
//
//  Created by Vinícius Rodrigues Duarte on 07/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager();
    var count = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //configuracoes iniciais do mapa
        mapView.delegate = self;
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // caso usuario nao der permissao do mapa
    // solicitar novamente
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse && status != .notDetermined{
            
            let alertController = UIAlertController(
                title: "Permissão para localização",
                message: "Para o funcionamento correto deste app é nescessário a permissão de sua localização, por favor habilite.",
                preferredStyle: .alert
            );
            
            // terceiro parametro eh uma closure.
            let configAction = UIAlertAction(
                title: "Abrir Configurações",
                style: .default) { (alertConfig) in
                    // abrir as configuracoes
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if count < 3 {
            centralizeMapView();
             count += 1;
        }else{
            locationManager.stopUpdatingLocation();
        }
        
    }
    
    func centralizeMapView(){
        if let coordinate = locationManager.location?.coordinate{
            let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    
    
    @IBAction func centralizePlayer(_ sender: Any) {
        centralizeMapView();
    }
    
    
    @IBAction func openPokedex(_ sender: Any) {
    }
    
    
}

