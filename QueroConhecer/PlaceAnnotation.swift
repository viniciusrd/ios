//
//  PlaceAnnotation.swift
//  QueroConhecer
//
//  Created by Vinicius Rodrigues on 06/04/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
import MapKit
class PlaceAnnotation: NSObject, MKAnnotation {
    
    enum PlaceType {
        case place
        case pointOfInterest
    }
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: PlaceType
    var address: String?
    
    
    init(coordinate: CLLocationCoordinate2D, type: PlaceType) {
        self.coordinate = coordinate
        self.type = type
    }
    
    
}
