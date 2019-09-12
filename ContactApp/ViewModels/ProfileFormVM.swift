//
//  ProfileFormVM.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 09/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import Foundation

protocol FormUpdatable {
    func update(with forItem: ProfileFormVM)
}

class ProfileFormVM {
    
    var value: String?
    var placeholder = ""
    var title = ""
    var tag = 0
    
    var indexPath: IndexPath?
    var valueCompletion: ((String?) -> Void)?
    
    init(title: String, placeholder: String, value: String? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
}
