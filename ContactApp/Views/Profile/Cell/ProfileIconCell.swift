//
//  ProfileIconCell.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 05/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class ProfileIconCell: UITableViewCell {

    @IBOutlet weak var profileIconView: UIView!
    
    var item: ProfileItem?
    {
        didSet {
            guard let item = item as? ProfileViewModelPicture else { return }
        }
    }
       
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileIconView.layer.cornerRadius = self.profileIconView.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
