//
//  ForgotPasswordViewController.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 11/02/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailView: CustomTextFieldView!
    @IBOutlet weak var sendButtonView: UIView!
    @IBOutlet weak var goBackSingInLabel: UILabel!
    
    //MARK: - Properties
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButtonView.layer.cornerRadius = 16
        sendButtonView.dropShadowForSocialLogin()
        goBackSingInLabel.font = FontManager.customFont(weight: .book, size: 15)
        
        let fullText = "Go back to Sign In"
        let customColor = UIColor(red: 206/255, green: 189/255, blue: 14/255, alpha: 1.0)
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "Sign In")
        attributedString.addAttribute(.foregroundColor, value:customColor , range: range)
        goBackSingInLabel.attributedText = attributedString
        configureTextFieldView(view: emailView, icon: UIImage.emailIcon, placeholder: "abc@email.com", textfieldType: .forgotEmail)
    }
    
    private func configureTextFieldView(view: CustomTextFieldView, icon: UIImage?, placeholder: String, textfieldType: TextFieldType,trailingIcon: UIImage? = nil) {
        let textFieldView = Bundle.main.loadNibNamed("CustomTextFieldView", owner: self, options: nil)?.first as? CustomTextFieldView
        textFieldView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textFieldView?.setupView()
        textFieldView?.frame = view.bounds
        textFieldView?.delegateTextfieldType = textfieldType
        textFieldView?.delegateTextField = self
        textFieldView?.configure(icon: icon, placeholder: placeholder,fontWeight: .light, fontSize: 14, trailingIcon: trailingIcon)
        view.addSubview(textFieldView!)
    }
    
    @IBAction func didClickBackToLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ForgotPasswordViewController: DelegateTextField {
    func didChangeTextField(with text: String, and type: TextFieldType) {
        switch type {
        case .forgotEmail:
            self.email = text
            break
        default:
            break
        }
    }
}
