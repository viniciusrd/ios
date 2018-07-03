//
//  ViewController.swift
//  Minhas Viagens
//
//  Created by Vinícius Rodrigues Duarte on 02/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapConfig();
        
        let gestureRecongnizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.markMap(gesture:)));
        gestureRecongnizer.minimumPressDuration = 2;
        map.addGestureRecognizer(gestureRecongnizer);
        
    }
    
    //chamado no seletor do reconhecimento dos gestos
    @objc func markMap(gesture: UIGestureRecognizer){
        
        //se foi o primeiro toque
        if gesture.state == UIGestureRecognizerState.began{
            let pointSelect = gesture.location(in: self.map);
            let coordinate = map.convert(pointSelect, toCoordinateFrom: self.map);
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            //recuperar o endereco
        
            var localComplete = "Endereço não encontrado!";
            
            CLGeocoder().reverseGeocodeLocation(location) { (local, erro) in
                if erro == nil
                {
                    if let dadosLocal = local?.first
                    {
                        if let localName = dadosLocal.name
                        {
                            localComplete = localName;
                        }
                        else
                        {
                            if let adress = dadosLocal.thoroughfare
                            {
                                localComplete = adress;
                            }
                        }
                    }
                    // exibir anotao com os dados do endereço
                    let annotation = MKPointAnnotation();
                    annotation.coordinate.latitude = coordinate.latitude;
                    annotation.coordinate.longitude = coordinate.longitude;
                    annotation.title = localComplete;
                    self.map.addAnnotation(annotation);
                }
                else
                {
                    print(erro);
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func mapConfig(){
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
    }
    

}

