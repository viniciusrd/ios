//
//  SettingsViewController.swift
//  Pensamentos
//
//  Created by Vinicius Rodrigues on 08/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var swAutoRefresh: UISwitch!
    @IBOutlet weak var slTimerInterval: UISlider!
    @IBOutlet weak var scColorScheme: UISegmentedControl!
    @IBOutlet weak var lbTimeInterval: UILabel!
    
    let config = Configuration.shared;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (Notification) in
            self.formatView();
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    func formatView()  {
        self.swAutoRefresh.setOn(config.autoRefresh, animated: true);
        self.slTimerInterval.setValue(Float(config.timeInterval), animated: true)
        self.scColorScheme.selectedSegmentIndex = config.colorScheme;
        changeTimeIntervalLabel(with: config.timeInterval);
        
    }
    
    func changeTimeIntervalLabel(with value: Double)  {
        lbTimeInterval.text = "Mudar após \(Int(value)) segundoss"
    }
    
    @IBAction func changeAutoRefresh(_ sender: UISwitch) {
        config.autoRefresh = sender.isOn;
    }
    
    @IBAction func changeTimeInterval(_ sender: UISlider) {
        let value = Double(round (sender.value));
        changeTimeIntervalLabel(with: value);
        config.timeInterval = value;
    }
    
    @IBAction func changeColorScheme(_ sender: UISegmentedControl) {
        config.colorScheme = sender.selectedSegmentIndex;
    }
    
}
