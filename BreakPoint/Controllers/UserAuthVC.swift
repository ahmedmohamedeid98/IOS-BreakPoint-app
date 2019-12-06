//
//  UserAuthVC.swift
//  BreakPoint
//
//  Created by ahmed on 12/5/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit

class UserAuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
