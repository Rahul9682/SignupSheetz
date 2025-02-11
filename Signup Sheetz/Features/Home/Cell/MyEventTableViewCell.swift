//
//  MyEventTableViewCell.swift
//  Signup Sheetz
//
//  Created by Braintech on 03/02/25.
//

import UIKit

class MyEventTableViewCell: UITableViewCell {
    
    //MARK: - Outlet's
    @IBOutlet weak var meetingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressIcon: UIImageView!
    
    //MARK: - Life-Cycle-Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        confiqureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    func configureCell(with event: EventModel) {
//        meetingLabel.text = event.title
//        addressLabel.text = event.address
//    }
    
    func confiqureUI() {
        addressIcon.image = UIImage.location
        meetingLabel.font = FontManager.customFont(weight: .medium, size: 16)
        addressLabel.font = FontManager.customFont(weight: .light, size: 13)
        addressLabel.textColor = UIColor.init(hex: "2B2849")
    }
}
