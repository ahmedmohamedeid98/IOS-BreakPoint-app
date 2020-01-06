//
//  GroupPostVC.swift
//  BreakPoint
//
//  Created by ahmed on 1/5/20.
//  Copyright © 2020 ahmed. All rights reserved.
//

import UIKit
import Firebase

class GroupPostVC: UIViewController {

    @IBOutlet weak var group_title: UILabel!
    @IBOutlet weak var group_members: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var comment_container_view: UIView!
    @IBOutlet weak var textField: PaddingTextField!
    @IBOutlet weak var sendButton_label: UIButton!
    var groupDetails: Group?
    var messageArray = [Message]()
    
    func initGroupPostVC(withGroup group: Group){
        groupDetails = group
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(groupPostCell.self, forCellReuseIdentifier: "GROUPPOSTCELL")
        comment_container_view.bindToKeyboard()
        group_title.text = groupDetails?.title
        
        DataServices.shared.getGroupMembers(membersId: (groupDetails?.members)!, handler: { (members) in
            self.group_members.text = members.joined(separator: ", ")
        })
        DataServices.shared.REF_GROUPS.observe(.value) { (_) in
            DataServices.shared.downloadAllGroupMessages(groupKey: (self.groupDetails?.key)!) { (messages) in
                self.messageArray = messages
                self.tableView.reloadData()
            }
        }
        sendButton_label.isEnabled = false
        textField.delegate = self
        
        
    }

    @IBAction func closeButtonWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonWasPressed(_ sender: Any) {
        self.sendButton_label.isEnabled = false
        if textField.text != "" {
            DataServices.shared.uploadPost(withMessage: textField.text!, userId:  (Auth.auth().currentUser?.uid)! , groupKey: groupDetails?.key) { (compeleted) in
                if compeleted {
                    print("perfect message upload")
                    self.textField.text = ""
                    self.sendButton_label.isEnabled = true
                }else{
                    
                    print("!!!--- Faild ---!!! in upload comment")
                }
            }
        }
    }
    
}
extension GroupPostVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GROUPPOSTCELL", for: indexPath) as? groupPostCell else {return UITableViewCell()}
        let img = UIImage(named: "defaultProfileImage")
        let msg = messageArray[indexPath.row]
        DataServices.shared.getUserEmail(withUID:msg.senterId) { (email) in
            cell.cellConfigure(image: img, email: email , comment: msg.content)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = messageArray[indexPath.row].content
        let size = CGSize(width: view.frame.width - 8 - 50 - 8 - 8, height: 1000)
        let attributes:[NSAttributedString.Key : UIFont] = [NSAttributedString.Key.font: UIFont(name: "Menlo", size: 18)! ]
        let estimated_Rect = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimated_Rect.height + 8 + 50 + 8 + 10
    }
    
    
}
extension GroupPostVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("heeeer")
        self.sendButton_label.isEnabled = true
    }
}
