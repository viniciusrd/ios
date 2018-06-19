//
//  ViewController.swift
//  CaraOuCoroa
//
//  Created by Vinícius Rodrigues Duarte on 17/06/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "jogarMoeda"
        {
            // get viewController to destine
            let viewControllerDestination  = segue.destination as! DetalhesViewController;
            
            viewControllerDestination.numeroRandom = Int(arc4random_uniform(2));
        }
    }


}

