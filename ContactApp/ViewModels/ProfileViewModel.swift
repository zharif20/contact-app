//
//  ProfileViewModel.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 11/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import Foundation
import UIKit

enum ProfileItemType {
    case picture
    case mainInformation
    case subInformation
}

protocol ProfileItem {
    var type: ProfileItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
    var headerSize: CGFloat { get }
    var cellSize: CGFloat { get }
}

class ProfileViewModel: NSObject {
    
    var items = [ProfileItem]()
    var fm = FileManager()
    
    var firstName: String? = ""
    var lastName: String? = ""
    var email: String? = ""
    var phone: String? = ""
    var contact: Contact?
    
    
    init(contact: Contact?) {
        super.init()
        self.contact = contact
        
        let modelPicture = ProfileViewModelPicture()
        
        let firstName = ProfileFormVM(title: "First Name", placeholder: "Enter your firstname")
        firstName.value = contact?.firstName
        firstName.tag = 100
        self.firstName = contact?.firstName
        firstName.valueCompletion = {[weak self, weak firstName] value in
            self?.firstName = value
            firstName?.value = value
        }
        
        let lastName = ProfileFormVM(title: "Last Name", placeholder: "Enter your lastname")
        lastName.value = contact?.lastName
        lastName.tag = 101
        self.lastName = contact?.lastName
        lastName.valueCompletion = {[weak self, weak lastName] value in
            self?.lastName = value
            lastName?.value = value
        }
        
        let mainInfo = [firstName, lastName]
        
        let email = ProfileFormVM(title: "Email", placeholder: "Enter your email")
        email.value = contact?.email
        email.tag = 102
        self.email = contact?.email
        email.valueCompletion = {[weak self, weak email] value in
            self?.email = value
            email?.value = value
        }
        
        let phone = ProfileFormVM(title: "Phone", placeholder: "Enter your phone")
        phone.value = contact?.phone
        phone.tag = 103
        self.phone = contact?.phone
        phone.valueCompletion = {[weak self, weak phone] value in
            self?.phone = value
            phone?.value = value
        }
        let subInfo = [email, phone]

        
        let modelMainInfo = ProfileViewModelMainInfo(info: mainInfo)
        let modelSubInfo = ProfileViewModelSubInfo(info: subInfo)

        self.items = [modelPicture, modelMainInfo, modelSubInfo]
    }
    
    func isValid(callback: (Bool, Contact?) -> Void) {
        if let firstName = firstName, let lastName = lastName {
            if firstName.isEmpty || lastName.isEmpty {
                callback(false,nil)
            } else {
                let c = Contact()
                c.firstName = firstName
                c.lastName = lastName
                c.email = email
                c.phone = phone
                callback(true,c)
            }
        } else {
            callback(false, nil)
        }
    }
    
    func saveNewData(contacts: [Contact], callback: (Bool) -> Void) {
        isValid { (isValid, c) in
            if isValid {
                var newContacts = [Contact]()
                for contact in contacts {
                    if (self.contact?.id == contact.id) {
                        if let value = c {
                            contact.firstName = value.firstName
                            contact.lastName = value.lastName
                            contact.email = value.email
                            contact.phone = value.phone
                        }
                    }
                    newContacts.append(contact)
                }
                writeToFile(encodeFile: newContacts)
                callback(true)
            } else {
                callback(false)
            }
        }
    }
    
    func writeToFile(encodeFile: Array<Contact>) {
        do {
            let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let subUrl = documentDirectory.appendingPathComponent("data.json")
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(encodeFile)
            try data.write(to: subUrl)
        } catch {
            
        }
    }
}

extension ProfileViewModel: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
            
        case .picture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileIconCell.identifier,
                                                        for: indexPath) as? ProfileIconCell
            {
                cell.item = item
                return cell
            }
        case .mainInformation:
            if let item = item as? ProfileViewModelMainInfo, let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewControllerCell.identifier, for: indexPath) as? ProfileViewControllerCell
            {
                let info = item.info[indexPath.row]
                cell.item = info
                cell.update(with: info)
                return cell
            }
        case .subInformation:
            if let item = item as? ProfileViewModelSubInfo, let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewControllerCell.identifier, for: indexPath) as? ProfileViewControllerCell
            {
                let info = item.info[indexPath.row]
                cell.item = info
                cell.update(with: info)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.items[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.items[section].headerSize
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.items[indexPath.section].cellSize
    }
}
