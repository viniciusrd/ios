//
//  WorldCup.swift
//  CampoesDasCopas
//
//  Created by Vinicius Rodrigues on 10/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation

struct WorldCup: Codable {
    let year: Int
    let country: String
    let winner: String
    let vice: String
    let winnerScore: String
    let viceScore: String
    let matches: [Match]
}
