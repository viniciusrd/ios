//
//  PlacesTableViewController.swift
//  QueroConhecer
//
//  Created by Vinicius Rodrigues on 16/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {
    
    var places: [ Place] = []
    var userDefaults = UserDefaults.standard
    var lbNoPlaces: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlaces()
        
        lbNoPlaces = UILabel()
        lbNoPlaces.text = "Cadastre os locais que desenha conhecer\n clicando no botao + acima"
        lbNoPlaces.textAlignment = .center
        lbNoPlaces.numberOfLines = 0
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "mapSegue"{
            let viewController = segue.destination as! PlacesFinderViewController
            viewController.delegate = self
        }else{
            let viewController = segue.destination as! MapViewController
            switch sender{
            case let place as Place:
                viewController.places = [place]
            default:
                viewController.places = places
            }
        }
    }
    
    func loadPlaces(){
        if let placesData = userDefaults.data(forKey: "places"){
            do {
                places = try JSONDecoder().decode([Place].self, from: placesData)
                tableView.reloadData();
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func savePlaces()  {
        do {
            let jsonPlaces = try? JSONEncoder().encode(places)
            userDefaults.set(jsonPlaces, forKey: "places")
        }
    }

    @objc func showAll(){
        performSegue(withIdentifier: "mapSegue", sender: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if places.count>0{
            let btShowAll = UIBarButtonItem(title: "Mostrar todos no mapa", style: .plain, target: self, action: #selector(showAll))
            navigationItem.leftBarButtonItem = btShowAll
            tableView.backgroundView = nil
        }else{
            navigationItem.leftBarButtonItem = nil
            tableView.backgroundView = lbNoPlaces
        }
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellLocation", for: indexPath)
        let place = places[indexPath.row]
        cell.textLabel?.text = place.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        performSegue(withIdentifier: "mapSegue", sender: place)
    }
    
    //Swipte para delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            places.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            savePlaces();
        }
    }

    

}

extension PlacesTableViewController: PlaceFinderDelegate{
    func addPlace(_ place: Place) {
        if !places.contains(place){
            places.append(place)
            savePlaces()
            tableView.reloadData()
        }
    }
}
