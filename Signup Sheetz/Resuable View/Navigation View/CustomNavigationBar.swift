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
    
    @IBOutlet weak var navigationLabel: UILabel!
    
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
    func configureUI(with leadingImage: UIImage?,topLabelText: String, bottomText: String, trailingImage: UIImage?) {
        containerView.backgroundColor = .clear
        
        let fullText = "\(topLabelText)\n\(bottomText)"
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let welcomeRange = (fullText as NSString).range(of: "\(topLabelText)")
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "F3F3F3"), range: welcomeRange)
        attributedString.addAttribute(.font, value: FontManager.customFont(weight: .book, size: 12), range: welcomeRange)
        
        let nameRange = (fullText as NSString).range(of: "\(bottomText)")
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "FEFEFE"), range: nameRange)
        attributedString.addAttribute(.font, value: FontManager.customFont(weight: .medium, size: 15), range: nameRange)
        
        navigationLabel.attributedText = attributedString
        navigationLabel.numberOfLines = 2
        navigationLabel.textAlignment = .left
        
        leadingImageView.image = leadingImage
        trailingImageView.image = trailingImage
    }
    
    //MARK: - BUTTONS
    @IBAction func didClickLeading(_ sender: UIControl) {
        didClickSideMenuButton?()
    }
    
    @IBAction func didClicktrailing(_ sender: UIControl) {
        didClickNotificationButton?()
    }
}
