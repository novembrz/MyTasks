//
//  RealmCell.swift
//  MyTasks
//
//  Created by Дарья on 16.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class RealmCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func switchAction(_ sender: UISwitch) {
        
        if sender.isOn{
            
        }
    }
    
}
