//
//  GameTableViewCell.swift
//  MyGames
//
//  Created by Vinicius Rodrigues on 01/05/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var ivGame: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with game:Game) {
        lbTitle.text = game.title
        lbConsole.text = game.console?.name ?? ""
        if let image = game.cover as? UIImage{
            ivGame.image = image
        }else{
            ivGame.image = UIImage(named: "noCover")
        }
    }

}
