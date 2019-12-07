//
//  UserAuthVC.swift
//  BreakPoint
//
//  Created by ahmed on 12/5/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit
import Firebase

class UserAuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func loginWithEmailWasPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func loginWithFacebookWasPressed(_ sender: Any) {
    }
    
    @IBAction func loginWithGoogleWasPressed(_ sender: Any) {
    }
    
}
