//
//  ContactList.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 08/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import Foundation

class ContactListVM {
    
    var contacts = [Contact]()
    var fm = FileManager()

    func getData() {
        if self.contacts.count > 0 {
            self.contacts.removeAll()
        }
        
        guard let mainURL = Bundle.main.url(forResource:"data", withExtension:".json") else { return }
        do {
            let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let subUrl = documentDirectory.appendingPathComponent("data.json")
            loadFile(path: mainURL, subPath: subUrl)
        } catch {
            print(error)
        }
    }
    
    func loadFile(path: URL, subPath: URL) {
        if fm.fileExists(atPath: subPath.path) {
            print("get data")
            decodeJSONData(pathName: subPath)
            
            if contacts.isEmpty {
                print("is empty")
                decodeJSONData(pathName: path)
            }
        } else {
            print("not exist")
            decodeJSONData(pathName: path)
        }
    }
    
    func decodeJSONData(pathName: URL) {
        do {
            let data = try Data(contentsOf: pathName)
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]]
            {
                for j in json {
                    let user = Contact()
                    user.phone = j["phone"] as? String
                    user.id = j["id"] as? String
                    user.firstName = j["firstName"] as? String
                    user.lastName = j["lastName"] as? String
                    user.email = j["email"] as? String
                    
                    self.contacts.append(user)
                }
            }
        } catch {
            print(error)
        }
        
    }
}
