//
//  ProfileForm.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 09/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import Foundation

class ProfileForm {
    var fm = FileManager()
    
    var formItems = [ProfileFormVM]()
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    
    
    init(user: Contact) {
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.email = user.email
        self.phone = user.phone
        
        self.configureItems()
    }
    
    @discardableResult
    func isValid() -> (Bool, Array<String>?) {
        var isValid = true
        var value = [String]()
        
        for i in self.formItems {
            if let item = i.value {
                i.checkValidity()
                if !i.isValid {
                    isValid = false
                }
                value.append(item)
            }
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
    
    private func configureItems() {
        let firstName = ProfileFormVM(title: "First Name", placeholder: "Enter your firstname")
        firstName.value = self.firstName
        firstName.tag = 100
        firstName.valueCompletion = {[weak self, weak firstName] value in
            self?.firstName = value
            firstName?.value = value
        }
        
        let lastName = ProfileFormVM(title: "Last Name", placeholder: "Enter your lastname")
        lastName.value = self.lastName
        lastName.tag = 101
        lastName.valueCompletion = {[weak self, weak lastName] value in
            self?.lastName = value
            lastName?.value = value
        }
        self.formItems = [firstName, lastName]
    }
}
