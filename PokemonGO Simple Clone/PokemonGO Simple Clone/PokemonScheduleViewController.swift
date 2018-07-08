//
//  PokemonScheduleViewController.swift
//  PokemonGO Simple Clone
//
//  Created by Vinícius Rodrigues Duarte on 08/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class PokemonScheduleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backToMap(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
