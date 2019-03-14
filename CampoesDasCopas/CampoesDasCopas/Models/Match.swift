//
//  Match.swift
//  CampoesDasCopas
//
//  Created by Vinicius Rodrigues on 10/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
struct Match: Codable {
    let stage: String
    let games: [Game]
}
