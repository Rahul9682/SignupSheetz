//
//  LogoutTableViewCell.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 13/02/25.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {

    @IBOutlet weak var logoutButton: UIButton!
    var onLogout: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func diidClickLogout(_ sender: UIButton) {
        onLogout?()
    }
}
