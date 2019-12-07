//
//  CreateGroupVC.swift
//  BreakPoint
//
//  Created by ahmed on 12/6/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {
    
    //MARK:- Properities
    @IBOutlet weak var titleField: PaddingTextField!
    @IBOutlet weak var descriptionField: PaddingTextField!
    @IBOutlet weak var addNewPeopleField: PaddingTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewPeopleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewPeopleField.delegate = self
        addNewPeopleField.addTarget(self, action: #selector(textFieldWasChanged), for: .editingChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneButton.isHidden = true
    }

    //MARK:- Configure func
    @objc func textFieldWasChanged(){
        if addNewPeopleField.text == "" {
            self.emailArray = []
            self.tableView.reloadData()
        }else{
            DataServices.shared.getEmail(withQuery: addNewPeopleField.text!) { (returnedAEmails) in
                self.emailArray = returnedAEmails
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK:- Configure Buttons
    @IBAction func doneButtonWasPressed(_ sender: Any) {
        
        if titleField.text != "" && descriptionField.text != ""{
            DataServices.shared.getIdes(withEmails: chosenUserArray) { (userIdes) in
                var allUserIdes = userIdes
                allUserIdes.append((Auth.auth().currentUser?.uid)!)
                DataServices.shared.createGroup(withTitle: self.titleField.text!, andDescription: self.descriptionField.text!, withUserIds: allUserIdes, handle: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? userCell else {
            return UITableViewCell()
        }
        let profileImage = UIImage(named: "defaultProfileImage")
        let email = emailArray[indexPath.row]
        if chosenUserArray.contains(email)
        {
            cell.configureCell(userImage: profileImage, email: email, isSelected: true)
        }
        else
        {
            cell.configureCell(userImage: profileImage, email: email, isSelected: false)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? userCell else { return }
        if !chosenUserArray.contains(cell.emailLabel.text!)
        {
            chosenUserArray.append(cell.emailLabel.text!)
            self.addNewPeopleLabel.text = chosenUserArray.joined(separator: ", ")
            doneButton.isHidden = false
        }
        else
        {
            chosenUserArray = chosenUserArray.filter({$0 != cell.emailLabel.text!})
            if chosenUserArray.count > 0
            {
                self.addNewPeopleLabel.text = chosenUserArray.joined(separator: ", ")
            }
            else
            {
                self.addNewPeopleLabel.text = "Add new people"
                doneButton.isHidden = true
            }
        }
    }
}


extension CreateGroupVC: UITextFieldDelegate{
    
}
