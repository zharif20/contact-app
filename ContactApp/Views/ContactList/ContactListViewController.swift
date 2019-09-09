//
//  ViewController.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 04/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {
    
    var refreshControl = UIRefreshControl()
    fileprivate var contactList = ContactListVM()
    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UINib(nibName: String(describing: MainViewControllerCell.self),
                                     bundle: Bundle(for: MainViewControllerCell.self)),
                               forCellReuseIdentifier: Constant.MainViewControllerCell)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactList = ContactListVM()
        
        refreshControl.attributedTitle = NSAttributedString(string:Constant.RefreshControlText)
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        
        self.contactList.getData()
    }
    
    @objc func refreshTable() {
        self.contactList.getData()
        if !self.contactList.contacts.isEmpty {
            self.refreshControl.endRefreshing()
        }
        self.tableView.reloadData()
    }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactList.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.MainViewControllerCell, for: indexPath) as! MainViewControllerCell
        let user = self.contactList.contacts[indexPath.row]
        cell.setContact(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constant.ProfileViewControllerId) as! ProfileViewController
        vc.user = self.contactList.contacts[indexPath.row]
        vc.contacts = self.contactList.contacts
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
