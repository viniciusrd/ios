//
//  TableViewCell.swift
//  CardTable
//
//  Created by Vinicius Rodrigues on 07/04/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
import UIKit
protocol TableViewCellDelegate: class {
    func didTapButton()
}
class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var delegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func clickedButton(_ sender: UIButton) {
        self.delegate?.didTapButton()
    }
}
