//
//  QuotesViewController.swift
//  Pensamentos
//
//  Created by Vinicius Rodrigues on 08/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController {

    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var lbQuote: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    
    let config = Configuration.shared;
    
    let quotesManager = QuotesManager()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (Notification) in
            self.formatView();
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.formatView();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.prepareQuote();
    }
    
    func formatView()  {
        self.view.backgroundColor = self.config.colorScheme == 0 ? .white : UIColor(red: 156.0/255, green: 68.0/255, blue: 15.0/255, alpha: 1.0);
        self.lbQuote.textColor = self.config.colorScheme == 0 ? .black : .white;
        self.lbAuthor.textColor = self.config.colorScheme == 0 ? UIColor(red: 192.0/255, green: 96.0/255, blue: 49.0/255, alpha: 1.0) : .yellow;
        self.prepareQuote();
    }
    
    func prepareQuote() {
        timer?.invalidate();
        if(self.config.autoRefresh){
            timer = Timer.scheduledTimer(withTimeInterval: self.config.timeInterval, repeats: true) { (timer) in
                self.showRandomQuote();
            }
        }
        
        self.showRandomQuote();
    }
    
    func showRandomQuote()  {
        let quote = quotesManager.gerRandomQuote();
        self.lbQuote.text = quote.quote;
        self.lbAuthor.text = quote.author;
        self.ivPhoto.image = UIImage(named: quote.image);
        self.ivBackground.image = ivPhoto.image;
        
        self.lbQuote.alpha = 0.0
        self.lbAuthor.alpha = 0.0
        self.ivPhoto.alpha = 0.0;
        self.ivBackground.alpha = 0.0;
        self.constraintTop.constant = 50;
        self.view.layoutIfNeeded();
        
        UIView.animate(withDuration: 2.5) {
            self.lbQuote.alpha = 1.0
            self.lbAuthor.alpha = 1.0
            self.ivPhoto.alpha = 1.0;
            self.ivBackground.alpha = 0.25;
            self.constraintTop.constant = 10;
            self.view.layoutIfNeeded();
        }
    }
    
}
