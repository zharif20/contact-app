//
//  ProfileViewModelPicture.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 13/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import Foundation
import UIKit

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
