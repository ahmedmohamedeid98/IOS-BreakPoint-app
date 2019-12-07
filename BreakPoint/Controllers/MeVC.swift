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

    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var userProfileAccount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
