//
//  Quote.swift
//  Pensamentos
//
//  Created by Vinicius Rodrigues on 08/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
struct Quote : Codable{
    
    let quote: String;
    let author: String;
    let image: String;
    
    
    
    var quetoFormatted: String{
        return "‟" + self.quote + " ”"
    }
    
    var authorFormatted: String {
        return "- " + self.author + " -"
    }
}
