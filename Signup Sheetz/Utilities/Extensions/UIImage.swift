//
//  UIImage.swift
//  Signup Sheetz
//
//  Created by Braintech on 27/01/25.
//

import UIKit

extension UIImage {
    static let emailIcon = UIImage(named: "Mail")
    static let passwordIcon = UIImage(named: "Lock")
    static let workIcon = UIImage(named: "work")
    static let phoneIcon = UIImage(named: "phone")
    static let profileIcon = UIImage(named: "Profile")
    static let closeEyeIcon = UIImage(named: "closeEye")
    static let userPlaceholder = UIImage(named: "user")
    static let bellIcon = UIImage(named: "bell")
    //
    static let homeTabIcon = UIImage(named: "Home")
    static let invitationTabIcon = UIImage(named: "Work")
    static let addEventRedIcon = UIImage(named: "add_event_icon")
    static let eventTabIcon = UIImage(named: "Category")
    static let profileTabIcon = UIImage(named: "Profile")
}

extension UIView {
    func dropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)  
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.25
        self.layer.masksToBounds = false
    }
    
    func dropShadowForSocialLogin() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.10
        self.layer.masksToBounds = false
    }
}
//
