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
    var coreDataPokemon: CoreDataPokemon!;
    var pokemons: [Pokemon] = [];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //configuracoes iniciais do mapa
        mapView.delegate = self;
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
        //Exibir os pokemons no mapa
        // executar a cada 5 segundos
        Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { (timer) in
            
            if let coordinate = self.locationManager.location?.coordinate{
                
                let totalPokemons = UInt32 (self.pokemons.count);
                let indexRandom = arc4random_uniform(totalPokemons);
                
                let pokemonGenereted = self.pokemons[Int(indexRandom)];
                
                let annotationMap = PokemonAnnotationMapView(coordinates: coordinate, pokemon: pokemonGenereted);
                
                let latRandom = (Double (arc4random_uniform(400)) - 250) / 100000.0;
                let logRandom = (Double (arc4random_uniform(400)) - 250) / 100000.0;
                
                
                annotationMap.coordinate.latitude += latRandom;
                annotationMap.coordinate.longitude += logRandom;
                self.mapView.addAnnotation(annotationMap);

            }
        }
        
        //recuperar os pokemons
        self.coreDataPokemon = CoreDataPokemon();
        self.pokemons = self.coreDataPokemon.getPokemons();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //substitui a annotation default do mapview
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil);
        
    
        if annotation is MKUserLocation{
            annotationView.image = #imageLiteral(resourceName: "player");
        }else{
            let pokemonAnnotation = (annotation as! PokemonAnnotationMapView).pokemon;
            annotationView.image = UIImage.init(named: pokemonAnnotation.nameImage!) ;
        }
        
        var frame = annotationView.frame;
        frame.size.height = 40;
        frame.size.width = 40;
        
        annotationView.frame = frame;
        
        return annotationView;
        
    }
    
    //anotacao do mapa selecionada
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let annotationMapView = view.annotation;
        let pokemon = (view.annotation as! PokemonAnnotationMapView).pokemon
        
        //desmarcar anotacao
        mapView.deselectAnnotation(annotationMapView, animated: true);
        
        if annotationMapView is MKUserLocation{
            return
        }
        // verificando as coordenadas da anotacao do mapa que no caso eh o pokemon
        // e ao clicar centralizar a tela naquela anotacao
        if let coordinateAnnotation = annotationMapView?.coordinate{
            let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinateAnnotation, 500, 500)
            self.mapView.setRegion(region, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            if let coord = self.locationManager.location?.coordinate{
                //funcao que verifica que um ponto esta dentro da area visivel
                if MKMapRectContainsPoint( self.mapView.visibleMapRect , MKMapPointForCoordinate(coord)) {
                    self.coreDataPokemon.salvarPokemon(pokemon: pokemon);
                    self.mapView.removeAnnotation(annotationMapView!);
                    
                    let alertController = UIAlertController(
                        title: "Pokemón GO Clone",
                        message: "Você conseguiu capturar o pokemon \(pokemon.name!)",
                        preferredStyle: .alert)
                    let ok = UIAlertAction(
                        title: "Ok",
                        style: .default,
                        handler: nil)
                    alertController.addAction(ok);
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }else{
                    let alertController = UIAlertController(
                        title: "Pokemón GO Clone",
                        message: "Ops!! Você precisa se aproximar mais para capturar o pokemon \(pokemon.name!)",
                        preferredStyle: .alert)
                    let ok = UIAlertAction(
                        title: "Ok",
                        style: .default,
                        handler: nil)
                    alertController.addAction(ok);
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
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

