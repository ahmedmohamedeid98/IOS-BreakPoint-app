//
//  DataServices.swift
//  BreakPoint
//
//  Created by ahmed on 12/5/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataServices{
    
    static let shared = DataServices()
    private let _REF_BASE = DB_BASE
    private let _REF_USERS = DB_BASE.child("users")
    private let _REF_GROUPS = DB_BASE.child("groups")
    private let _REF_FEED = DB_BASE.child("feed")
    
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    var REF_GROUPS: DatabaseReference{
        return _REF_GROUPS
    }
    var REF_FEED: DatabaseReference{
        return _REF_FEED
    }
    // push user data into user database
    func createDBUser(uid: String, uData: Dictionary<String, Any>){
        REF_USERS.child(uid).updateChildValues(uData)
    }
    
    
}
