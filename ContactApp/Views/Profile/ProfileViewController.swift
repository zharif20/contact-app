//
//  ProfileViewController.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 04/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user = Contact()
    var contacts = [Contact]()
    var profileForm: ProfileForm?
    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UINib(nibName: String(describing: ProfileViewControllerCell.self),
                                     bundle: Bundle(for: ProfileViewControllerCell.self)),
                               forCellReuseIdentifier: Constant.ProfileViewControllerCell)
            tableView.register(UINib(nibName: String(describing: ProfileIconCell.self),
                                     bundle: Bundle(for: ProfileIconCell.self)),
                               forCellReuseIdentifier: Constant.ProfileIconCell)
            
            tableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileForm = ProfileForm(user: user)
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        // check the id
        // do a for loop
        // add all in an array
        // do check based on the id
        // then update the id
        // save to the new file
        var newContacts = [Contact]()

        for contact in self.contacts {
            if (user.id == contact.id) {
                if let value = self.profileForm?.isValid().1 {
                    contact.firstName = value[0]
                    contact.lastName = value[1]
                }
            }
            newContacts.append(contact)
        }
        
        
        self.profileForm?.writeToFile(encodeFile: newContacts)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.ProfileIconCell, for: indexPath) as! ProfileIconCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.ProfileViewControllerCell, for: indexPath) as! ProfileViewControllerCell
        if indexPath.section == 1 {
            if let item = self.profileForm?.formItems[indexPath.row]{
                if let formUpdatableCell = cell as? FormUpdatable
                {
                    item.indexPath = indexPath
                    formUpdatableCell.update(with: item)
                }
            }
        } else {
            if indexPath.row == 0 {
                cell.infoLabel.text = "Email"
                cell.infoTextfield.text = user.email
                
            } else {
                cell.infoLabel.text = "Phone"
                cell.infoTextfield.text = user.phone
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Main Information"
        } else if section == 2 {
            return "Sub Information"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat
        
        switch section {
        case 0:
            headerHeight = 0
        default:
            headerHeight = UITableView.automaticDimension
        }
        return headerHeight
    }
    
    
}
