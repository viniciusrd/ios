//
//  GameViewController.swift
//  MyGames
//
//  Created by Vinicius Rodrigues on 01/05/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbTitle.text = game.title
        lbConsole.text = game.console?.name
        guard let releaseDate = game.releaseDate else {
            lbReleaseDate.text = ""
            return
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "pt-BR")
        lbReleaseDate.text = "Lançamento: \(formatter.string(from: releaseDate))"
        guard let image = game.cover as? UIImage else {
            ivCover.image = UIImage(named: "noCoverFull")
            return
        }
        ivCover.image = image
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddEditViewController
        vc.game = game
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
