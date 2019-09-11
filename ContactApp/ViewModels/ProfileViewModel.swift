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
    var profileInfo = [ProfileFormVM]()
    var fm = FileManager()
    
    init(contact: Contact) {
        super.init()

        let modelPicture = ProfileViewModelPicture()
        
        
        let firstName = ProfileFormVM(title: "First Name", placeholder: "Enter your firstname")
        firstName.value = contact.firstName
        firstName.tag = 100
        firstName.valueCompletion = {[weak firstName] value in
            firstName?.value = value
        }
        
        let lastName = ProfileFormVM(title: "Last Name", placeholder: "Enter your lastname")
        lastName.value = contact.lastName
        lastName.tag = 101
        lastName.valueCompletion = {[weak lastName] value in
            lastName?.value = value
        }
        
        let mainInfo = [firstName, lastName]
        
        let email = ProfileFormVM(title: "Email", placeholder: "Enter your email")
        email.value = contact.email
        email.tag = 102
        email.valueCompletion = {[weak email] value in
            email?.value = value
        }
        
        let phone = ProfileFormVM(title: "Phone", placeholder: "Enter your phone")
        phone.value = contact.phone
        phone.tag = 103
        phone.valueCompletion = {[weak phone] value in
            phone?.value = value
        }
        let subInfo = [email, phone]

        
        let modelMainInfo = ProfileViewModelMainInfo(info: mainInfo)
        let modelSubInfo = ProfileViewModelSubInfo(info: subInfo)

        self.items = [modelPicture, modelMainInfo, modelSubInfo]
        
        self.profileInfo = mainInfo + subInfo
        
    }
    
    @discardableResult
    func isValid() -> (Bool, Array<String>?) {
        var isValid = true
        var value = [String]()
        
        for i in self.profileInfo {
            if let item = i.value {
                i.checkValidity()
                if !i.isValid {
                    isValid = false
                }
                value.append(item)
            }
            print(value)
        }
        return (isValid, value)
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


class ProfileViewModelPicture: ProfileItem {
    var type: ProfileItemType
    {
        return .picture
    }
    
    var sectionTitle: String
    {
        return ""
    }
    
    var rowCount: Int
    {
        return 1
    }
    
    var headerSize: CGFloat
    {
        return 0
    }
    
    var cellSize: CGFloat
    {
        return 150
    }
    
    init() {
        
    }
}


class ProfileViewModelMainInfo: ProfileItem {
    var type: ProfileItemType
    {
        return .mainInformation
    }
    
    var sectionTitle: String
    {
        return "Main Information"
    }
    
    var rowCount: Int
    {
        return info.count
    }
    
    var headerSize: CGFloat
    {
        return UITableView.automaticDimension
    }
    
    var cellSize: CGFloat
    {
        return UITableView.automaticDimension
    }
    
    var info: [ProfileFormVM]
    
    init(info: [ProfileFormVM]) {
        self.info = info
    }
}

class ProfileViewModelSubInfo: ProfileItem {
    var type: ProfileItemType
    {
        return .subInformation
    }
    
    var sectionTitle: String
    {
        return "Sub Information"
    }
    
    var rowCount: Int
    {
        return info.count
    }
    
    var headerSize: CGFloat
    {
        return UITableView.automaticDimension
    }
    
    var cellSize: CGFloat
    {
        return UITableView.automaticDimension
    }
    
    var info: [ProfileFormVM]
    
    init(info: [ProfileFormVM]) {
        self.info = info
    }
}
