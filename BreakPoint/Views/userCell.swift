//
//  userCell.swift
//  BreakPoint
//
//  Created by ahmed on 12/6/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit

class userCell: UITableViewCell {

   
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var checkmarkImage: UIImageView!
    //var showing: Bool = false
    
    func configureCell(userImage image: UIImage?, email: String, isSelected: Bool){
        self.userImage.image = image
        self.emailLabel.text = email
        if isSelected
        {
            self.checkmarkImage.isHidden = false
        }
        else
        {
            self.checkmarkImage.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected
        {
            if !self.checkmarkImage.isHidden
            {
                self.checkmarkImage.isHidden = true
            }
            else
            {
                self.checkmarkImage.isHidden = false
            }
        }
    }

}
