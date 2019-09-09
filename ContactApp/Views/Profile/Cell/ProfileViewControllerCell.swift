//
//  ProfileViewControllerCell.swift
//  ContactApp
//
//  Created by M. Zharif Hadi M. Khairuddin on 05/09/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class ProfileViewControllerCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoTextfield: UITextField!
    
    var profileFormVM: ProfileFormVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.infoTextfield.delegate = self
        self.infoTextfield.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.profileFormVM?.valueCompletion?(textField.text)
    }
}

extension ProfileViewControllerCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = self.superview?.viewWithTag(nextTag) as UIResponder?
        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        
        return false
    }
}

extension ProfileViewControllerCell: FormUpdatable {
    func update(with forItem: ProfileFormVM) {
        self.profileFormVM = forItem
        self.infoLabel.text = forItem.title
        self.infoTextfield.tag = forItem.tag
        self.infoTextfield.text = forItem.value
        self.infoTextfield.placeholder = forItem.placeholder
    }
    
}
