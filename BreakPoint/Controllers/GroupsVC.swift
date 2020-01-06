//
//  SecondViewController.swift
//  BreakPoint
//
//  Created by ahmed on 12/5/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    //MARK:- Properities
    @IBOutlet weak var tableView: UITableView!
    var groupsArray = [Group]()
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //this make any any change in the firebase data update group table
        DataServices.shared.REF_GROUPS.observe(.value) { (datasnapshot) in
            // getGroupsDetails execution just one time
            DataServices.shared.getGourpsDetails { (groups) in
                self.groupsArray = groups
                self.tableView.reloadData()
            }
        }
        
    }
    
}
//MARK:- Extentions
extension GroupsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? groupCell else {
            return UITableViewCell()
        }
        let group = groupsArray[indexPath.row]
        cell.configureCell(title: group.title, description: group.description, membersCount: group.memberCount)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let GroupPostVC = storyboard?.instantiateViewController(withIdentifier: "GroupPostVC") as? GroupPostVC else {return}
        GroupPostVC.initGroupPostVC(withGroup: groupsArray[indexPath.row])
        present(GroupPostVC, animated: true, completion: nil)
        
    }
}
