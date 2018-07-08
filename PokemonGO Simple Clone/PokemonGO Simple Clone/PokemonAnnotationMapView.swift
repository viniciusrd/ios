//
//  PokemonAnnotationMapView.swift
//  PokemonGO Simple Clone
//
//  Created by Vinícius Rodrigues Duarte on 08/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotationMapView: NSObject ,MKAnnotation   {
    
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coordinates: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordinates;
        self.pokemon = pokemon;
    }
    
    
    
}
