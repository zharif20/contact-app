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
    
    fileprivate var viewModel: ProfileViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProfileViewModel(contact: user)
        
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        
        tableView.register(ProfileViewControllerCell.nib,
                           forCellReuseIdentifier: ProfileViewControllerCell.identifier)
        tableView.register(ProfileIconCell.nib,
                           forCellReuseIdentifier: ProfileIconCell.identifier)
        
        tableView.tableFooterView = UIView()
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        var newContacts = [Contact]()

        for contact in self.contacts {
            if (user.id == contact.id) {
                if let value = self.viewModel?.isValid().1 {
                    contact.firstName = value[0]
                    contact.lastName = value[1]
                    contact.email = value[2]
                    contact.phone = value[3]
                }
            }
            newContacts.append(contact)
        }
        
        self.viewModel?.writeToFile(encodeFile: newContacts)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
