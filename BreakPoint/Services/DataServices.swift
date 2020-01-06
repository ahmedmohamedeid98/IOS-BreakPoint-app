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
    func uploadPost(withMessage message: String, userId uid: String, groupKey: String?, sendCompelete: @escaping (_ status: Bool)->()){
            if groupKey != nil {
                REF_GROUPS.child(groupKey!).child("Messages").childByAutoId().updateChildValues(["content": message, "sender": uid])
                sendCompelete(true)
        }else{
            REF_FEED.childByAutoId().updateChildValues(["content": message, "sender": uid])
            sendCompelete(true)
        }
    }
    
    func getUserEmail(withUID uid: String, handler: @escaping(_ email : String) -> ()){
        REF_USERS.observeSingleEvent(of: .value) { (DataSnapshot) in
            guard let dataSnapshot = DataSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in dataSnapshot {
                if user.key == uid {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    handler(email)
                    return
                }
            }
        }
    }
    
    func downloadAllFeedMessages(handler: @escaping(_ messages: [Message]) -> ()){
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (allDataSanpchat) in
            guard let dataSnapchat = allDataSanpchat.children.allObjects as? [DataSnapshot] else {
                handler([])
                return }
            for message in dataSnapchat{
                let content = message.childSnapshot(forPath: "content").value as! String
                let sender = message.childSnapshot(forPath: "sender").value as! String
                let message = Message(content: content, senderId: sender)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
    
    
    func getEmail(withQuery query: String, handler: @escaping (_ emails:[String])-> ()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (dataSnapshot) in
            guard let data = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                handler([])
                return
            }
            for user in data{
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIdes(withEmails emails:[String], handler:@escaping(_ idesArray:[String])->()){
        var idesArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (DataSnapshot) in
            guard let users = DataSnapshot.children.allObjects as? [DataSnapshot] else{
                handler([])
                return}
            for user in users{
                let email = user.childSnapshot(forPath: "email").value as! String
                if emails.contains(email){
                    idesArray.append(user.key)
                }
            }
            handler(idesArray)
        }
    }
    
    func createGroup(withTitle title:String, andDescription description:String, withUserIds ides: [String], handle: @escaping(_ groupCreated:Bool)->()){
        REF_GROUPS.childByAutoId().updateChildValues(["title":title, "description":description, "members":ides])
        handle(true)
    }
    
    func getGourpsDetails(handler:@escaping (_ groups:[Group])->()){
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let groups = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                handler([])
                return
            }
            for group in groups{
                let members = group.childSnapshot(forPath: "members").value as! [String]
                //make sure this group belong me not the other's groups.
                if members.contains((Auth.auth().currentUser?.uid)!){
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let desc = group.childSnapshot(forPath: "description").value as! String
                    let theGroup = Group(title: title, description: desc, key: group.key, members: members)
                    groupsArray.append(theGroup)
                }
            }
            handler(groupsArray)
        }
    }
    
    func downloadAllGroupMessages(groupKey: String, handler:@escaping (_ messages:[Message])->()){
        var messagesArray = [Message]()
        REF_GROUPS.child(groupKey).child("Messages").observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let data = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for message in data{
                let content = message.childSnapshot(forPath: "content").value as! String
                let sender = message.childSnapshot(forPath: "sender").value as! String
                let msg = Message(content: content, senderId: sender)
                messagesArray.append(msg)
            }
            handler(messagesArray)
        }
    }
    
    func getGroupMembers(membersId: [String], handler:@escaping (_ members:[String]) -> ()){
        var membersArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let data = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
                for user in data{
                    if membersId.contains(user.key){
                        membersArray.append((user.childSnapshot(forPath: "email").value as? String)!)
                    }
                }
            handler(membersArray)
        }
    }
    
    
    
}
