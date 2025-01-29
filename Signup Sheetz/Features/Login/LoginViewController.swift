//
//  ViewController.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 23/01/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Outlet's
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailView: CustomTextFieldView!
    @IBOutlet weak var passwordView: CustomTextFieldView!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signInButtonView: UIView!
    @IBOutlet weak var appleSignInView: UIView!
    @IBOutlet weak var googleSignInView: UIView!
    
    var email = ""
    var password = ""
    
    
    //MARK: - Life-Cycle-Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        confiqureUI()
        configureTextFieldView(view: emailView, icon: UIImage.emailIcon, placeholder: "abc@email.com", textfieldType: .loginEmail)
        configureTextFieldView(view: passwordView, icon: UIImage.passwordIcon, placeholder: "your password", textfieldType: .loginPassword)
        
    }
    
    private func configureTextFieldView(view: CustomTextFieldView, icon: UIImage?, placeholder: String, textfieldType: TextFieldType) {
        let textFieldView = Bundle.main.loadNibNamed("CustomTextFieldView", owner: self, options: nil)?.first as? CustomTextFieldView
        textFieldView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textFieldView?.setupView()
        textFieldView?.frame = view.bounds
        textFieldView?.delegateTextfieldType = textfieldType
        textFieldView?.delegateTextField = self
        textFieldView?.configure(icon: icon, placeholder: placeholder,fontWeight: .light, fontSize: 14)
        view.addSubview(textFieldView!)
    }
    
    func confiqureUI() {
        titleLabel.text = "Sign In"
        titleLabel.font = FontManager.customFont(weight: .medium, size: 24)
        signUpLabel.font = FontManager.customFont(weight: .book, size: 15)
        let fullText = "Don’t have an account?  Sign Up"
        let customColor = UIColor(red: 206/255, green: 189/255, blue: 14/255, alpha: 1.0)
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "Sign Up")
        attributedString.addAttribute(.foregroundColor, value:customColor , range: range)
        signUpLabel.attributedText = attributedString
        
        signInButtonView.layer.cornerRadius = 16
        appleSignInView.layer.cornerRadius = 16
        googleSignInView.layer.cornerRadius = 16
        signInButtonView.dropShadow()
        appleSignInView.dropShadowForSocialLogin()
        googleSignInView.dropShadowForSocialLogin()
        
        
    }
    
    
    //MARK: - Button Actions
    @IBAction func SignUpPageAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension LoginViewController: DelegateTextField {
    func didChangeTextField(with text: String, and type: TextFieldType) {
        switch type {
        case .loginEmail:
            self.email = text
            break
        case .loginPassword:
            self.password = text
            break
        default:
            break
        }
    }
}
