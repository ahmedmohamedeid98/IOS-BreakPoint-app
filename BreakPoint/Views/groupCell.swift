//
//  groupCell.swift
//  BreakPoint
//
//  Created by ahmed on 12/7/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit

class groupCell: UITableViewCell {
    
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var membersNumberLabel: UILabel!
    
    func configureCell(title: String, description: String, membersCount: Int){
        self.groupTitleLabel.text = title
        self.descriptionLable.text = description
        self.membersNumberLabel.text = "\(membersCount) members"
    }
    
}
