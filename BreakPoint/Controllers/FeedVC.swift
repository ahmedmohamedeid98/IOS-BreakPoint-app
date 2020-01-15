//
//  FeedVC.swift
//  BreakPoint
//
//  Created by ahmed on 12/5/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {//, GetUserMessagesInFeed {
    
    //MARK:- Properities
    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [Message]()
    
    // Confirm Protocol
    /*
    func getAllMessagesInFeed(userId uid: String) -> [String] {
        print("~~~~~~Enterd Protocol~~~~~~~")
        var userMessages = [String]()
        for message in messageArray{
            if message.senterId == uid{
                userMessages.append(message.content)
            }
        }
        return userMessages
    }
    */
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FeedCell.self, forCellReuseIdentifier: "FeedCellIdentifier")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataServices.shared.downloadAllFeedMessages { (messages) in
            self.messageArray = messages.reversed()
            self.tableView.reloadData()
        }
        
    }

   
}
//MARK:- Configure TableView
extension FeedVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCellIdentifier", for: indexPath) as? FeedCell else {return UITableViewCell()}

        let message = messageArray[indexPath.row]
        DataServices.shared.getUserEmail(withUID: message.senterId) { (email) in
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage"), email: email, text: message.content)
        }
        return cell
    }
    
    // configure a dynamic cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = messageArray[indexPath.row].content
        let size = CGSize(width: view.frame.width - 8 - 50 - 8 - 8, height: 1000)
        let attributes:[NSAttributedString.Key : UIFont] = [NSAttributedString.Key.font: UIFont(name: "Menlo", size: 18)! ]
        let estimated_Rect = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimated_Rect.height + 8 + 50 + 8 + 50 + 30
    }
    
}
