//
//  PokemonScheduleViewController.swift
//  PokemonGO Simple Clone
//
//  Created by Vinícius Rodrigues Duarte on 08/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class PokemonScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonsCaptured: [Pokemon] = [];
    var pokemonsNotCaptured: [Pokemon] = [];

    override func viewDidLoad() {
        super.viewDidLoad()

        let coreData = CoreDataPokemon();
        self.pokemonsCaptured = coreData.getPokemonCaptured(capturedParam: true);
        self.pokemonsNotCaptured = coreData.getPokemonCaptured(capturedParam: false);
        
        print(String (self.pokemonsNotCaptured.count))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Capturados"
        }else{
            return "Não Capturados"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.pokemonsCaptured.count;
        }else{
            return self.pokemonsNotCaptured.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemon: Pokemon;
        
        if indexPath.section == 0{
            pokemon = self.pokemonsCaptured[indexPath.row];
        }else{
            pokemon = self.pokemonsNotCaptured[indexPath.row];
        }
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "reuseCellPokemons");
        cell.imageView?.image = UIImage (named: pokemon.nameImage!);
        cell.textLabel?.text = pokemon.name;
        
        
        return cell;
    }
    

    @IBAction func backToMap(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
