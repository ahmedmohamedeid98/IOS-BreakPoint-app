//
//  UIViewExt.swift
//  BreakPoint
//
//  Created by ahmed on 12/6/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit

extension UIView{
    
    //MARK:- bind view to keybaord
    
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: Notification){
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let beginChange = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endChange = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endChange.origin.y - beginChange.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
        
    }
    
    //MARK:- configure view constraint
    func withConstraints(_ top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, margins:UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top{
            anchors.append(topAnchor.constraint(equalTo: top, constant: margins.top))
        }
        if let left = left{
            anchors.append(leftAnchor.constraint(equalTo: left, constant: margins.left))
        }
        if let right = right{
            anchors.append(rightAnchor.constraint(equalTo: right, constant: margins.right * -1))
        }
        if let bottom = bottom{
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: margins.bottom * -1))
        }
        if size.width  > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: size.width))
        }
        if size.height > 0{
            anchors.append(heightAnchor.constraint(equalToConstant: size.height))
        }
        
        NSLayoutConstraint.activate(anchors)
    }
}
