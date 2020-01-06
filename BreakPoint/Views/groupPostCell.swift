//
//  groupPostCell.swift
//  BreakPoint
//
//  Created by ahmed on 1/5/20.
//  Copyright © 2020 ahmed. All rights reserved.
//

import UIKit

class groupPostCell: UITableViewCell {

    let userIamge: UIImageView = {
        let image = UIImageView()
        return image
    }()
    let userEmail: UILabel = {
        let label = UILabel()
        return label
    }()
    let comment: UITextView = {
        let text = UITextView()
        return text
    }()
    
    func cellConfigure(image: UIImage?, email: String, comment: String){
        self.userIamge.image = image
        self.userEmail.text = email
        self.comment.text = comment
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){
        addSubview(userIamge)
        addSubview(userEmail)
        addSubview(comment)
        
        userIamge.withConstraints(topAnchor, left: leftAnchor, right: nil, bottom: nil, margins: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 0), size: CGSize(width: 50, height: 50))
        userEmail.withConstraints(userIamge.topAnchor, left: userIamge.rightAnchor, right: rightAnchor, bottom: nil, margins: UIEdgeInsets(top: 5, left: 8, bottom: 0, right: 8))
        comment.withConstraints(userIamge.bottomAnchor, left: userIamge.rightAnchor, right: rightAnchor, bottom: bottomAnchor, margins: UIEdgeInsets(top: 5, left: 8, bottom: 8, right: 8))
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
