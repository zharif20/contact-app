//
//  ProfileViewController.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 04/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: Contact?
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
        viewModel?.saveNewData(contacts: self.contacts, callback: { (isSuccess) in
            if isSuccess {
                self.navigationController?.popViewController(animated: true)
            } else {
                let alert = UIAlertController(title: "Missing field",
                                              message: "Please Enter first name and last name",
                                              preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
            }
        })
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
