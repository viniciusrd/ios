//
//  ColorPickerViewController.swift
//  Mensagens
//
//  Created by Vinicius Rodrigues on 06/03/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import UIKit

protocol ColorPickerDelegate: class {
    func applyColor(color: UIColor)
}

class ColorPickerViewController: UIViewController {

    @IBOutlet weak var viColor: UIView!
    @IBOutlet weak var slRed: UISlider!
    @IBOutlet weak var slGreen: UISlider!
    @IBOutlet weak var slBlue: UISlider!
    
    weak var delegate: ColorPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func changeColor(_ sender: UISlider) {
        
        viColor.backgroundColor = UIColor(red: CGFloat( slRed.value ), green: CGFloat( slGreen.value ), blue: CGFloat( slBlue.value ), alpha: 1.0)
    }
    
    
    @IBAction func choseColor(_ sender: UIButton) {
        dismiss(animated: true, completion: nil);
        delegate?.applyColor(color: viColor.backgroundColor!)
    }
    
    
}
