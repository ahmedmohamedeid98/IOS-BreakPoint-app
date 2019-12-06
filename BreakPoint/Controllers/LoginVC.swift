//
//  LoginVC.swift
//  BreakPoint
//
//  Created by ahmed on 12/5/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: PaddingTextField!
    @IBOutlet weak var passwordField: PaddingTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signInButtonWasPressed(_ sender: Any) {
        
        if emailField.text != nil && passwordField.text != nil{
            AuthServices.shared.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!) { (success, error) in
                if success {
                    print("Successfully Logined\n")
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    print(String(describing: error?.localizedDescription))
                    AuthServices.shared.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, registerCompleted: { (success, error) in
                        if success {
                            AuthServices.shared.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginCompleted: { (success, nil) in
                                if success{
                                    self.dismiss(animated: true, completion: nil)
                                    print("Successfully registered\n")
                                }else{
                                    print("Login Faild")
                                }
                            })
                        }
                    })
                }
            }
        }
        
    }
    
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
