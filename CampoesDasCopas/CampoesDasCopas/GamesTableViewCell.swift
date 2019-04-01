//
//  GamesTableViewCell.swift
//  CampoesDasCopas
//
//  Created by Vinicius Rodrigues on 16/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class GamesTableViewCell: UITableViewCell {

    @IBOutlet weak var ivWinner: UIImageView!
    @IBOutlet weak var ivVice: UIImageView!
    @IBOutlet weak var lbWinner: UILabel!
    @IBOutlet weak var lvVice: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
    func prepare(with game: Game)  {
        ivWinner.image = UIImage(named: "\(game.home).png")
        ivVice.image = UIImage(named: "\(game.away).png")
        lbWinner.text = game.home
        lvVice.text = game.away
        lbScore.text = game.score;
    }

}
