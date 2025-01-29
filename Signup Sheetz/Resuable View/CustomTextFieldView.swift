//
//  CustomTextFieldView.swift
//  Signup Sheetz
//
//  Created by Braintech on 27/01/25.
//


import UIKit

@IBDesignable
class CustomTextFieldView: UIView {

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
     func setupView() {
        // Add rounded border
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configure(icon: UIImage?, placeholder: String, fontWeight: FontManager.FontWeight, fontSize: CGFloat) {
        iconImageView.image = icon
        textField.placeholder = placeholder
        textField.font = FontManager.customFont(weight: fontWeight, size: fontSize)
    }
    
   

}
