//
//  ProfileViewModelSubInfo.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 13/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import Foundation
import UIKit

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

