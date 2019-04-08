//
//  ViewController.swift
//  CardTable
//
//  Created by Vinicius Rodrigues on 07/04/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha:  1)
        cell.label.text = "Card: \(indexPath)"
        cell.delegate = self
        
        return cell
    }


}

extension ViewController: TableViewCellDelegate{
    func didTapButton() {
        print("clicked")
    }
}

