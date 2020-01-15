//
//  MeFeedCell.swift
//  BreakPoint
//
//  Created by ahmed on 1/5/20.
//  Copyright © 2020 ahmed. All rights reserved.
//

import UIKit

class MeFeedCell: UITableViewCell {
    
    
    var myPosts: UITextView = {
        let txt = UITextView()
        txt.text = "TEST TEST TEST"
        return txt
    }()
    

    func configureCell(post: String){
        self.myPosts.text = post
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){
        addSubview(myPosts)
        myPosts.withConstraints(topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, margins: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
