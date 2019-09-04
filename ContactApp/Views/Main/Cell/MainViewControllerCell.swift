//
//  MainViewControllerCell.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 04/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class MainViewControllerCell: UICollectionViewCell {

    @IBOutlet weak var profileIconView: UIView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profileIconView.layer.cornerRadius = self.profileIconView.frame.size.width/2
        
    }

}
