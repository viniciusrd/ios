//
//  ViewController.swift
//  Som dos Bichos
//
//  Created by Vinícius Rodrigues Duarte on 09/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var sound = AVAudioPlayer();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dog(_ sender: Any) {
        self.executeSound(nameAnimal: "cao")
    }
    @IBAction func cat(_ sender: Any) {
        self.executeSound(nameAnimal: "gato")
    }
    @IBAction func lion(_ sender: Any) {
        self.executeSound(nameAnimal: "leao")
    }
    @IBAction func monkey(_ sender: Any) {
        self.executeSound(nameAnimal: "macaco")
    }
    @IBAction func sheep(_ sender: Any) {
        self.executeSound(nameAnimal: "ovelha")
    }
    @IBAction func cow(_ sender: Any) {
        self.executeSound(nameAnimal: "vaca")
    }
    
    
    func executeSound(nameAnimal: String){
        
        if let path = Bundle.main.path(forResource: nameAnimal, ofType: "mp3"){
            let url  = URL(fileURLWithPath: path);
            
            do{
                self.sound   = try AVAudioPlayer(contentsOf: url)
                self.sound.prepareToPlay();
                sound.play();
                
            } catch{
                print("erro")
            }
        }
    }
}

