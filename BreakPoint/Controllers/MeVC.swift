//
//  MeVC.swift
//  BreakPoint
//
//  Created by ahmed on 12/6/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    //MARK:- Properities
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userProfileAccount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var feedMessages = [String]()
    ////var delegate: GetUserMessagesInFeed?
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileAccount.text = Auth.auth().currentUser?.email
        tableView.register(MeFeedCell.self, forCellReuseIdentifier: "MEFEEDCELL")
        tableView.register(MeGroupsCell.self, forCellReuseIdentifier: "MEGROUPSCELL")
        /*
        print("Auth_UID: \(String(describing: Auth.auth().currentUser?.uid))")
        if let mydelegate = self.delegate {
            print("in delegate \\\\")
            feedMessages = mydelegate.getAllMessagesInFeed(userId: (Auth.auth().currentUser?.uid)!)
        }
         */
    }
    
    
    
    //MARK:- Configure Buttons
    @IBAction func singoutButtonWasPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Logout?", message: "Are you sure to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (logoutTapped) in
            do{
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "UserAuthVC") as! UserAuthVC
                self.present(authVC, animated: true, completion: nil)
                
            }catch{
                print(error)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
extension MeVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return feedMessages.count
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: "MEFEEDCELL", for: indexPath) as? MeFeedCell else {return UITableViewCell()}
            cell1.configureCell(post: feedMessages[indexPath.row])
            return cell1
        }
        
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "MEGROUPSCELL", for: indexPath) as? MeGroupsCell else {return UITableViewCell()}
        
        return cell2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 50
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Your Posts in feed"
        }
        return "Your Posts in groups"
    }
    
    
}
