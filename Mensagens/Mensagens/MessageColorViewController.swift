//
//  MessageColorViewController.swift
//  Mensagens
//
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class MessageColorViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMessage.text = message.text;
        lbMessage.textColor = message.textColor;
        lbMessage.backgroundColor = message.backgroundColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ScreenColorViewController;
        viewController.message = self.message;
    }
}

extension MessageColorViewController: ColorPickerDelegate{
    
    func applyColor(color: UIColor){
        lbMessage.backgroundColor = color;
        message.backgroundColor = color;
    }
}

