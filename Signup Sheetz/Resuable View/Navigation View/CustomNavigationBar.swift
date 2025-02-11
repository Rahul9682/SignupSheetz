//
//  NavigationBar.swift
//  AdvanceProject
//
//  Created by braintech on 08/11/21.
//

import UIKit

class CustomNavigationBar: UIView {
    
    //MARK: - OUTLETS
    @IBOutlet weak var containerView: UIView!
//    @IBOutlet weak var backButton: UIButton!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var notificationButton: UIButton!
//    @IBOutlet weak var navigationLogoImageView: UIImageView!
    @IBOutlet weak var leadingContainerView: UIView!
    @IBOutlet weak var leadingImageView: UIImageView!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var trailingContainerView: UIView!
    @IBOutlet weak var trailingImageView: UIImageView!
    
    
    
    //MARK: - PROPERTIES
    var didClickSideMenuButton: (() -> Void)?
    var didClickNotificationButton: (() -> Void)?
    
    //MARK: - LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - HELPERS
    func configureUI(with leadingImage: UIImage?,topLabelText: String?,bottomLabelText: String?, trailingImage: UIImage?) {
        containerView.backgroundColor = .clear
        topLabel.textColor = UIColor.init(hex: "F3F3F3")
        topLabel.text = topLabelText
        topLabel.font = FontManager.customFont(weight: .book, size:12)
        topLabel.numberOfLines = 2
        
        bottomLabel.textColor = UIColor.init(hex: "FEFEFE")
        bottomLabel.text = bottomLabelText
        bottomLabel.font = FontManager.customFont(weight: .medium, size:14)
        
        leadingImageView.image = leadingImage
        trailingImageView.image = trailingImage
//        backButton?.setImage(backImageIcon, for: .normal)
//        backButton.tintColor = tintColor
//        notificationButton.setImage(notificationImageIcon, for: .normal)
//        notificationButton.tintColor = tintColor
//        notificationButton.setTitleColor(tintColor, for: .normal)
//        notificationButton.setTitle(notificationBuutonTitle, for: .normal)
        
//        if isNavigationLogo {
//            navigationLogoImageView.isHidden = false
//            navigationLogoImageView.image = UIImage(named: "Group 34056")
//        } else {
//            navigationLogoImageView.isHidden = true
//        }
    }
    
    //MARK: - BUTTONS
    @IBAction func didClickLeading(_ sender: UIControl) {
        didClickSideMenuButton?()
    }
    
    @IBAction func didClicktrailing(_ sender: UIControl) {
        didClickNotificationButton?()
    }
}
