//
//  ShadowView.swift
//  BreakPoint
//
//  Created by ahmed on 12/5/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }

}
