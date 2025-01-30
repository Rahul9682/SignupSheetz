//
//  CustomTextFieldView.swift
//  Signup Sheetz
//
//  Created by Braintech on 27/01/25.
//


import UIKit

@IBDesignable
class CustomTextFieldView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    var delegateTextField: DelegateTextField?
    var delegateTextfieldType: TextFieldType?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
     func setupView() {
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configure(icon: UIImage?, placeholder: String, fontWeight: FontManager.FontWeight, fontSize: CGFloat) {
        iconImageView.image = icon
        textField.placeholder = placeholder
        textField.font = FontManager.customFont(weight: fontWeight, size: fontSize)
        switch delegateTextfieldType {
        case .loginPassword, .signupPassword:
            textField.returnKeyType = .done
        default:
            textField.returnKeyType = .next
        }
    }
    
    @IBAction func searchTextFieldAction(_ sender: UITextField) {
        let textfieldText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if let delegateTextField = delegateTextField, let type = delegateTextfieldType {
            delegateTextField.didChangeTextField(with: textfieldText, and: type)
        }
    }
}
