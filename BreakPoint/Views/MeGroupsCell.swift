//
//  MeGroupsCell.swift
//  BreakPoint
//
//  Created by ahmed on 1/5/20.
//  Copyright © 2020 ahmed. All rights reserved.
//

import UIKit

class MeGroupsCell: UITableViewCell {

    var myPosts: UITextView = {
        let txt = UITextView()
        txt.text = "My Posts"
        return txt
    }()
    
    var groupTitle: UILabel = {
        let title = UILabel()
        title.text = "Group title"
        return title
    }()
    
    
    func configureCell(post: String, forGroupTitle title: String){
        self.myPosts.text = post
        self.groupTitle.text = title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){
        addSubview(groupTitle)
        addSubview(myPosts)
        groupTitle.withConstraints(topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, margins: UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 4), size: CGSize(width: 0, height: 30))
        myPosts.withConstraints(groupTitle.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, margins: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
