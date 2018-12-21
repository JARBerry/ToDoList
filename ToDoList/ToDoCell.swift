//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Ray Berry on 21/12/2018.
//  Copyright © 2018 JARBerry. All rights reserved.
//

import UIKit

@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    var delegate: ToDoCellDelegate?

    @IBOutlet weak var isCompleteButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    @IBAction func completedButtonTapped() {
        delegate?.checkmarkTapped(sender: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
