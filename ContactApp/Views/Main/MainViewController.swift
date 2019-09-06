//
//  ViewController.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 04/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let cellId = "MainViewControllerCell"
    
    var contacts = [Contact]()
    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
            tableView.register(UINib(nibName: String(describing: MainViewControllerCell.self),
                                     bundle: Bundle(for: MainViewControllerCell.self)),
                               forCellReuseIdentifier: cellId)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]]
                {
                    for j in json {
                        let user = Contact()
                        
                        user.phone = j["phone"] as? String
                        user.contactId = j["id"] as? String
                        user.firstname = j["firstName"] as? String
                        user.lastname = j["lastName"] as? String
                        user.email = j["email"] as? String
                        
                        self.contacts.append(user)
                    }
                }
                self.tableView.reloadData()
            } catch {
                // handle error
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainViewControllerCell
        let user = self.contacts[indexPath.row]
        if let firstname = user.firstname, let lastname = user.lastname {
            cell.profileNameLabel.text = "\(firstname) \(lastname)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
