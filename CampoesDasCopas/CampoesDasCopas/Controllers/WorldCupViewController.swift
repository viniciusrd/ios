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
    @IBOutlet weak var tableView: UITableView!
    
    
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

extension WorldCupViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return worldCup.matches.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let games = worldCup.matches[section].games
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTrajetoria", for: indexPath) as! GamesTableViewCell
        let match = worldCup.matches[indexPath.section]
        let game = match.games[indexPath.row]
        
        cell.prepare(with: game)

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let match = worldCup.matches[section]
        return match.stage
    }
}

extension WorldCupViewController: UITableViewDelegate{
    
}
