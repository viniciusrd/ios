//
//  MapViewController.swift
//  QueroConhecer
//
//  Created by Vinicius Rodrigues on 16/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viInfo: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func showRoute(_ sender: UIButton) {
        
    }
    
    
    @IBAction func showSearchBar(_ sender: Any) {
        
    }
    
}
