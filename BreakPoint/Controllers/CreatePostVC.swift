//
//  CreatePostVC.swift
//  BreakPoint
//
//  Created by ahmed on 12/6/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    //MARK:- Properities
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendButton.isEnabled = false
        //textView.inputAccessoryView = sendButton

    }
    //MARK:- setup Actions
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonWasPressed(_ sender: Any) {
        sendButton.isEnabled = false
        if textView.text != nil && textView.text != "Write something here ..."{
            DataServices.shared.uploadPost(withMessage: textView.text!, userId: (Auth.auth().currentUser?.uid)!, groupKey: nil) { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    self.sendButton.isEnabled = true
                }else{
                    self.sendButton.isEnabled = true
                    print("Error message not sending")
                }
            }
        }
        
        
    }
}

//MARK:- extentions
extension CreatePostVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        self.sendButton.isEnabled = true
    }
}
