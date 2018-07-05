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
    var travel: Dictionary<String,String> = [:];
    var indexSelected: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        if let index = indexSelected{
            if index == -1{
                mapConfig();
            }else{
                showAnnotationMap(travel: self.travel);
            }
        }
        
        //rechonecedor de gesto
        let gestureRecongnizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.markMap(gesture:)));
        gestureRecongnizer.minimumPressDuration = 2;
        map.addGestureRecognizer(gestureRecongnizer);
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let local = locations.last!;
        //exibir local do usuario
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(local.coordinate.latitude, local.coordinate.longitude);
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01);
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span);
        self.map.setRegion(region, animated: true);
    }
    
    //montar anotacao da marcacao
    func showAnnotationMap(travel: Dictionary<String,String>){
        // exibir anotao com os dados do endereço
        if let local = travel["local"]{
            if let latitudeS = travel["latitude"]{
                if let longitudeS = travel["longitude"]{
                    if let latitude = Double(latitudeS){
                        if let longitude = Double(longitudeS)
                        {
                            
                            let annotation = MKPointAnnotation();
                            annotation.coordinate.latitude = latitude;
                            annotation.coordinate.longitude = longitude;
                            annotation.title = local;
                            self.map.addAnnotation(annotation);
                            
                            //exibir local do usuario
//                            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude);
//                            let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01);
//                            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span);
//                            self.map.setRegion(region, animated: true);

                            showLocal(latitude: latitude, longitude: longitude);
                        }
                    }
                    
                    
                    
                }
            }
        }
    }
    
    func showLocal(latitude: Double, longitude: Double){
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude);
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01);
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span);
        self.map.setRegion(region, animated: true);
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
                    //salvar viagem
                    
                    self.travel = ["local":localComplete, "latitude": String(coordinate.latitude),"longitude":String(coordinate.longitude)];
                    ArmazenamentoDados().toSaveTravel(travel: self.travel);
                    
                    self.showAnnotationMap(travel: self.travel);
                    
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

