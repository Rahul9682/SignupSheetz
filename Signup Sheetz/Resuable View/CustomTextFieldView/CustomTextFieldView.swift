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
    @IBOutlet weak var trailingImageView: UIImageView!
     
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
    
    func configure(icon: UIImage?, placeholder: String, fontWeight: FontManager.FontWeight, fontSize: CGFloat,trailingIcon: UIImage?) {
        iconImageView.image = icon
        iconImageView.tintColor = UIColor.init(hex:"807A7A")
        
        trailingImageView.image = trailingIcon
        trailingImageView.tintColor = UIColor.init(hex:"807A7A")
        
        textField.placeholder = placeholder
        textField.font = FontManager.customFont(weight: fontWeight, size: fontSize)
        switch delegateTextfieldType {
        case .loginPassword, .signupPassword:
            textField.isSecureTextEntry = true
            textField.returnKeyType = .done

        case .loginEmail, .signupEmail:
            textField.keyboardType = .emailAddress  //
            textField.autocapitalizationType = .none //
            textField.autocorrectionType = .no  //
            textField.returnKeyType = .next
        
        case .signupPhoneNumber:
            textField.keyboardType = .phonePad

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
    
    @IBAction func showPasswordAction(_ sender: Any) {
        guard delegateTextfieldType == .loginPassword || delegateTextfieldType == .signupPassword else {
                return
            }
            textField.isSecureTextEntry.toggle()
            let image = textField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
            trailingImageView.image = image
    }
    
    
    
}
