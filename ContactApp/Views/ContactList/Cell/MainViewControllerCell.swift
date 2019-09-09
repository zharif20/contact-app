//
//  MainViewControllerCell.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 05/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class MainViewControllerCell: UITableViewCell {

    @IBOutlet weak var profileIconView: UIView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileIconView.layer.cornerRadius = self.profileIconView.frame.size.width/2
    }
    
    func setContact(user: Contact) {
        if let firstname = user.firstName, let lastname = user.lastName {
            self.profileNameLabel.text = "\(firstname) \(lastname)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
    }
    
}
