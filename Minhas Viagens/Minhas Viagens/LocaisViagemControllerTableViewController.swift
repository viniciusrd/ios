//
//  LocaisViagemControllerTableViewController.swift
//  Minhas Viagens
//
//  Created by Vinícius Rodrigues Duarte on 02/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class LocaisViagemControllerTableViewController: UITableViewController {
    
    var locais: [Dictionary<String,String>] = [];
    var controlNavigation: String = "Add";

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        controlNavigation = "Add";
        updateTravel();
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locais.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let viagem = locais[ indexPath.row ]["local"];
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaViagem", for: indexPath);
        cell.textLabel?.text = viagem;

        return cell;
    }
   

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            ArmazenamentoDados().toRemoveTravel(index:indexPath.row);
            updateTravel();
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //metodo para startar uma segue
        self.controlNavigation = "List";
        performSegue(withIdentifier: "showMap", sender: indexPath.row);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if self.controlNavigation == "List"{
            let viewControllerDestiny = segue.destination as! ViewController;
            if segue.identifier == "showMap"{
                
                
                if let getIndex = sender{
                    let index = getIndex as! Int;
                    
                    viewControllerDestiny.travel = locais[index];
                    viewControllerDestiny.indexSelected = index;
                    
                }
            }else{
                viewControllerDestiny.travel = [:];
                viewControllerDestiny.indexSelected = -1;
            }
        }
    }
    
    func updateTravel(){
        locais = ArmazenamentoDados().toListTravel();
        tableView.reloadData();
    }

}
