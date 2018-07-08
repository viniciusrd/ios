//
//  CoreDataPokemon.swift
//  PokemonGO Simple Clone
//
//  Created by Vinícius Rodrigues Duarte on 07/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit
import CoreData

class CoreDataPokemon {
    
    // recuperar o contexto
    func getContext() -> NSManagedObjectContext{
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate;
        let context = appDelegate?.persistentContainer.viewContext;
        
        return context!;
    }
    
    // adcionar todos pokemon
    func addAllPokemons() {
        
        let context = self.getContext();
        
        self.createPokemon(name: "Mew", nameImage: "mew", captured: false)
        self.createPokemon(name: "Meowth", nameImage: "meowth", captured: false)
        self.createPokemon(name: "Pikachu", nameImage: "pikachu-2", captured: false)
        self.createPokemon(name: "Squirtle", nameImage: "squirtle", captured: false)
        self.createPokemon(name: "Charmander", nameImage: "charmander", captured: false)
        self.createPokemon(name: "Caterpie", nameImage: "caterpie", captured: false)
        self.createPokemon(name: "Bullbarsaur", nameImage: "bullbarsaur", captured: false)
        self.createPokemon(name: "Bellsprout", nameImage: "bellsprout", captured: false)
        self.createPokemon(name: "Psyduck", nameImage: "psyduck", captured: false)
        self.createPokemon(name: "Rattata", nameImage: "rattata", captured: false)
        self.createPokemon(name: "Snorlax", nameImage: "snorlax", captured: false)
        self.createPokemon(name: "Zubat", nameImage: "zubat", captured: false)
        
        do {
            try context.save();
        } catch let execption {
            print("Erro : \(execption.localizedDescription)");
        }
        
    }
    
    
    // criar os pokemons
    func createPokemon(name: String, nameImage:String, captured: Bool){
        
        let context = self.getContext();
        let pokemon = Pokemon(context: context);
        pokemon.name = name;
        pokemon.nameImage = nameImage;
        pokemon.captured = captured;
        
    }
    
    func getPokemons() -> [Pokemon]{
        
        let context = self.getContext();
        
        do {
            let pokemons = try context.fetch( Pokemon.fetchRequest() ) as! [Pokemon];
            
            if pokemons.count == 0{
                self.addAllPokemons();
                return self.getPokemons();
            }
            return pokemons;
        } catch let exception {
            print(exception);
        }
        
        return [];
        
    }
    
}
