//
//  WorldCupViewController.swift
//  CampoesDasCopas
//
//  Created by Vinicius Rodrigues on 10/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class WorldCupViewController: UIViewController {

    @IBOutlet weak var ivWinner: UIImageView!
    @IBOutlet weak var ivVice: UIImageView!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbWinner: UILabel!
    @IBOutlet weak var lbVice: UILabel!
    
    
    var worldCup: WorldCup!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "World Cup \(worldCup.year)"
        ivWinner.image =  UIImage(named: "\(worldCup.winner).png")
        ivVice.image =  UIImage(named: "\(worldCup.vice).png")
        lbWinner.text =  worldCup.winner
        lbVice.text =  worldCup.winner
        lbScore.text = "\(worldCup.winnerScore) x \(worldCup.viceScore)"
        
    }
    
}
