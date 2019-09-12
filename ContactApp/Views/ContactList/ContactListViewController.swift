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
    fileprivate var viewModel: ContactListViewModel?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ContactListViewModel()
        viewModel?.contactVC = self
        
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        
        tableView.register(MainViewControllerCell.nib,
                           forCellReuseIdentifier: MainViewControllerCell.identifier)
        
        refreshControl.attributedTitle = NSAttributedString(string:Constant.RefreshControlText)
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    @objc func refreshTable() {
        viewModel?.refreshData(callback: { (isEmpty) in
            if isEmpty {
                self.refreshControl.endRefreshing()
            }
        })
        self.tableView.reloadData()
    }
}
