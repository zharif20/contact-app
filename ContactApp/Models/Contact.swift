//
//  Contact.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 05/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import Foundation

class Contact: NSObject, Codable {
    var email: String? = ""
    var firstName: String? = ""
    var id: String? = ""
    var lastName: String? = ""
    var phone: String? = ""
    
    override init() {
    }
    
    init(j: [String: Any]) {
        self.phone = j["phone"] as? String
        self.id = j["id"] as? String
        self.firstName = j["firstName"] as? String
        self.lastName = j["lastName"] as? String
        self.email = j["email"] as? String
    }
    
}
