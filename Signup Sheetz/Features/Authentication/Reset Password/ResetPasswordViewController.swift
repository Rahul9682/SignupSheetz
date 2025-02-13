//
//  ResetPasswordViewController.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 11/02/25.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var passwordView: CustomTextFieldView!
    @IBOutlet weak var confirmPasswordView: CustomTextFieldView!
    @IBOutlet weak var sendButtonView: UIView!
    @IBOutlet weak var goBackLabel: UILabel!
    
    //MARK: - Properties
    var email = ""
    var password = ""
    var confirmPassword = ""
    private var viewModel = ResetPasswordViewModel(email: "", password: "", confirmPassword: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        sendButtonView.layer.cornerRadius = 16
        sendButtonView.dropShadowForSocialLogin()
        goBackLabel.font = FontManager.customFont(weight: .book, size: 15)
        pageTitleLabel.font = FontManager.customFont(weight: .medium, size: 24)
        
        let fullText = "Go back to Previous page"
        let customColor = UIColor(red: 206/255, green: 189/255, blue: 14/255, alpha: 1.0)
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "Previous page")
        attributedString.addAttribute(.foregroundColor, value:customColor , range: range)
        goBackLabel.attributedText = attributedString
        
        configureTextFieldView(view: passwordView, icon: UIImage.passwordIcon, placeholder: "Enter your new password", textfieldType: .resetPassword,trailingIcon:UIImage(systemName: "eye.slash"))
        configureTextFieldView(view: confirmPasswordView, icon: UIImage.passwordIcon, placeholder: "Confirm your new password", textfieldType: .resetConfirmPassword,trailingIcon:UIImage(systemName: "eye.slash"))
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyBoard))
//        view.addGestureRecognizer(tap)
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
    
    @IBAction func didClickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickSendForForReset(_ sender: UIControl) {
        resetPassword()
    }
    
    @IBAction func didClickGoBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ResetPasswordViewController: DelegateTextField {
    func didChangeTextField(with text: String, and type: TextFieldType) {
        switch type {
        case .resetPassword:
            self.password = text
            break
        case .resetConfirmPassword:
            self.confirmPassword = text
            break
        default:
            break
        }
    }
}

//MARK: - VIEWMODEL INTERACTIONS
extension ResetPasswordViewController {
    private func resetPassword() {
        viewModel = ResetPasswordViewModel(email: self.email.trimmingCharacters(in: .whitespacesAndNewlines), password: self.password.trimmingCharacters(in: .whitespacesAndNewlines), confirmPassword: self.confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines))
        
        viewModel.validation { result in
            switch result {
            case .success(_):
                self.viewModel.resetPassword { result in
                    switch result {
                    case .success(let message):
                        
                        print("success :: \(message)")
                        self.showOKAlert(with: "Success", and: message) { alert in
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    case .failure(let error):
                        self.showOKAlert(with: "Error", and: error.localizedDescription) { alert in
                          
                        }
                    }
                }
            case .failure(let error):
                self.showOKAlert(with: "Error", and: error.localizedDescription) { alert in
                   
                }
            }
        }
    }
}
