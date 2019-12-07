//
//  FeedCell.swift
//  BreakPoint
//
//  Created by ahmed on 12/6/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    //MARK:- User Properities
    var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "defaultProfileImage")
        return imageView
    }()
    
    var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "useremail@breakpoint.com"
        label.font = UIFont(name: "Menlo", size: 18)
        label.textColor = #colorLiteral(red: 0, green: 0.7235742211, blue: 0.8151144385, alpha: 1)
        return label
    }()
    
    var postText: UITextView = {
        let txv = UITextView()
        txv.font = UIFont(name: "Menlo", size: 18)
        txv.textColor = #colorLiteral(red: 0, green: 0.7235742211, blue: 0.8151144385, alpha: 1)
        txv.backgroundColor = .clear
        txv.isEditable = false
        //txv.isScrollEnabled = false
        return txv
    }()
    
    //MARK:- Cell Buttons (like - comment - share)
    let likeBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "like-icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    let commentBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "comment-icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    let shareBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "share-icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    //MARK:- Init Cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2901960784, blue: 0.3137254902, alpha: 1)
        setupView()
        setupStackView()
    }
    
    //MARK:- Configure Cell
    func configureCell(profileImage: UIImage?, email: String, text: String){
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        self.postText.text = text
    }
    
    
    //MARK:- setup Cell View
    func setupView(){
        addSubview(profileImage)
        addSubview(emailLabel)
        addSubview(postText)
        
        profileImage.withConstraints(safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: nil, bottom: nil, margins: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 0), size: CGSize(width: 50.0, height: 50.0))
        
        emailLabel.withConstraints(profileImage.topAnchor, left: profileImage.rightAnchor, right: rightAnchor, bottom: nil, margins: UIEdgeInsets(top: 15, left: 8, bottom: 0, right: 8), size: CGSize(width: 0, height: 20))
        
        postText.withConstraints(profileImage.bottomAnchor, left: profileImage.rightAnchor, right: rightAnchor, bottom: bottomAnchor, margins: UIEdgeInsets(top: 8, left: 8, bottom: 50, right: 8), size: .zero)
    }
    
    //MARK:- setup Cell Buttons
    func setupStackView(){
        let likeViewContrainer = UIView()
        let commentViewContrainer = UIView()
        let shareViewContrainer = UIView()
        
        // configure stackView
        let stackView = UIStackView(arrangedSubviews: [shareViewContrainer, commentViewContrainer, likeViewContrainer])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        // add views to FeedCell
        addSubview(stackView)
        addSubview(likeBtn)
        addSubview(commentBtn)
        addSubview(shareBtn)
        
        // configure view's constraints
        stackView.withConstraints(nil, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, size: CGSize(width: 0, height: 40))
        
        likeBtn.withConstraints(likeViewContrainer.topAnchor, left: likeViewContrainer.leftAnchor, right: likeViewContrainer.rightAnchor, bottom: likeViewContrainer.bottomAnchor)
        commentBtn.withConstraints(commentViewContrainer.topAnchor, left: commentViewContrainer.leftAnchor, right: commentViewContrainer.rightAnchor, bottom: commentViewContrainer.bottomAnchor)
        
        shareBtn.withConstraints(shareViewContrainer.topAnchor, left: shareViewContrainer.leftAnchor, right: shareViewContrainer.rightAnchor, bottom: shareViewContrainer.bottomAnchor)
        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
