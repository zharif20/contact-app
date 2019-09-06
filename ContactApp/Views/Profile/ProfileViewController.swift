//
//  ProfileViewController.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 04/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let cellId = "ProfileViewControllerCell"
    let cellIconId = "ProfileIconCell"

    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UINib(nibName: String(describing: ProfileViewControllerCell.self),
                                     bundle: Bundle(for: ProfileViewControllerCell.self)),
                               forCellReuseIdentifier: cellId)
            tableView.register(UINib(nibName: String(describing: ProfileIconCell.self),
                                     bundle: Bundle(for: ProfileIconCell.self)),
                               forCellReuseIdentifier: cellIconId)
            
            tableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func saveButtonTapped(_ sender: Any) {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIconId, for: indexPath) as! ProfileIconCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProfileViewControllerCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
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
