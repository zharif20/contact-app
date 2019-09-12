//
//  ContactListViewModel.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 11/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import Foundation
import UIKit

enum ContactType {
    case info
}

protocol ContactItem {
    var type: ContactType { get }
    var rowCount: Int { get }
    var headerSize: CGFloat { get }
    var cellSize: CGFloat { get }
}

class ContactListViewModel: NSObject {
    
    var items = [ContactItem]()
    var contactVC: ContactListViewController?
    
    fileprivate var contactList = ContactListVM()
    
    override init() {
        super.init()
        self.contactList = ContactListVM()
        self.contactList.getData()
        let contactsInfo = ContactViewModelInfo(contacts: self.contactList.contacts)
        self.items = [contactsInfo]
    }
    
    func refreshData(callback: (Bool) -> Void) {
        self.contactList.getData()
        if !self.contactList.contacts.isEmpty {
            callback(true)
        }
        callback(false)
    }
}

extension ContactListViewModel: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        
        switch item.type {
        case .info:
            if let item = item as? ContactViewModelInfo, let cell = tableView.dequeueReusableCell(withIdentifier: MainViewControllerCell.identifier, for: indexPath) as? MainViewControllerCell
            {
                let contact = item.contacts[indexPath.row]
                cell.item = contact
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constant.ProfileViewControllerId) as! ProfileViewController
        vc.user = self.contactList.contacts[indexPath.row]
        vc.contacts = self.contactList.contacts
        contactVC?.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactListViewModel: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.items[indexPath.section].cellSize
    }
}

