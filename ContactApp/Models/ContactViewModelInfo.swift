//
//  ContactViewModelInfo.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 13/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import Foundation
import UIKit

class ContactViewModelInfo: ContactItem {
    var type: ContactType
    {
        return .info
    }
    
    var rowCount: Int
    {
        return contacts.count
    }
    
    var headerSize: CGFloat
    {
        return 0
    }
    
    var cellSize: CGFloat
    {
        return 80
    }
    
    var contacts: [Contact]
    
    init(contacts: [Contact]) {
        self.contacts = contacts
    }
}
