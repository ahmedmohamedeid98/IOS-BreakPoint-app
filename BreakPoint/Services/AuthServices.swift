//
//  AuthServices.swift
//  BreakPoint
//
//  Created by ahmed on 12/5/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import Foundation
import Firebase

class AuthServices{
    
    static let shared = AuthServices()
    
    func registerUser(withEmail email: String, andPassword password: String, registerCompleted: @escaping(_ status: Bool, _ error: Error?)-> () ){
        
        Auth.auth().createUser(withEmail: email, password: password) { (AuthDataResult, error) in
            guard let authData = AuthDataResult else {
                registerCompleted(false, error)
                return
            }
            
            let userData:Dictionary<String, Any> = ["provider": authData.user.providerID , "email": authData.user.email ?? "@missing email"]
            DataServices.shared.createDBUser(uid: authData.user.uid, uData: userData)
            registerCompleted(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginCompleted: @escaping(_ status: Bool, _ error: Error?)-> ()){
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil{
                loginCompleted(false, error)
                return
            }
            loginCompleted(true, nil)
        }
        
    }
    
}
