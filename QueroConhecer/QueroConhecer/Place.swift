//
//  Place.swift
//  QueroConhecer
//
//  Created by Vinicius Rodrigues on 16/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
import MapKit

struct Place: Codable {
    
    let name: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let address: String
    
    var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
   
    
    static func getFormattedAddress(with placemark: CLPlacemark) -> String{
        var address = ""
        // TODO: Rua
        if let street = placemark.thoroughfare{
            address += street
        }
        // TODO: Número
        if let number = placemark.subThoroughfare{
            address += " \(number)"
        }
        // TODO: Bairro
        if let subLocality = placemark.subLocality{
            address += ", \(subLocality)"
        }
        // TODO: Cidade
        if let city = placemark.locality{
            address = "\n \(city)"
        }
        // TODO: Estado
        if let state = placemark.administrativeArea{
            address = " - \(state)"
        }
        //TODO: CEP
        if let postalCode = placemark.postalCode{
            address = "\nCEP: \(postalCode)"
        }
        
        if let country = placemark.country{
            address = "\nCEP: \(country)"
        }
        
        
        return address
    }
    
    
}

extension Place: Equatable{
    static func == (lhs: Place, rhs: Place) -> Bool{
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
