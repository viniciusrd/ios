//
//  ViewController.swift
//  Player Sound
//
//  Created by Vinícius Rodrigues Duarte on 09/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer();

    @IBOutlet weak var sliderVolume: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "bach", ofType: "mp3"){
            let url  = URL(fileURLWithPath: path);
            
            do{
                player   = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay();
                
            } catch{
                print("erro")
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateVolume(_ sender: Any) {
        player.volume = sliderVolume.value
    }

    @IBAction func stop(_ sender: Any) {
        player.stop();
        player.currentTime = 0;
    }
    @IBAction func pause(_ sender: Any) {
        player.pause();
        
    }
    
    @IBAction func play(_ sender: Any) {
        player.play();
    }
}

