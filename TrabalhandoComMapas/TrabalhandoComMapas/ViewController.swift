//
//  ViewController.swift
//  TrabalhandoComMapas
//
//  Created by Vinícius Rodrigues Duarte on 30/06/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reponsavel por delegar o location manager sera essa classe
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //chama a permisao configurada no Info.plist - neste caso 
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
//        //Shopping Contagem
//        let latitude: CLLocationDegrees = -19.880763;
//        let longitude: CLLocationDegrees =  -44.037795;
//
//        //define o zoom
//        let deltaLatitude: CLLocationDegrees = 0.02;
//        let deltaLongitude: CLLocationDegrees = 0.02;
//
//
//        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude);
//        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude);
//
//        let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao);
//
//        mapa.setRegion(regiao, animated: true);
//
//        let anotacao = MKPointAnnotation();
//        // configurar anotacao
//
//        anotacao.coordinate = localizacao;
//        anotacao.title = "Shopping Contagem";
//        anotacao.subtitle = "";
//
//        mapa.addAnnotation(anotacao);
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations.last!;
        
        //monta a exibicao do mapa
        
        let latitude: CLLocationDegrees = userLocation.coordinate.latitude;
        let longitude: CLLocationDegrees =  userLocation.coordinate.longitude;

        //define o zoom
        let deltaLatitude: CLLocationDegrees = 0.02;
        let deltaLongitude: CLLocationDegrees = 0.02;


        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude);
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude);

        let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao);

        mapa.setRegion(regiao, animated: true);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

