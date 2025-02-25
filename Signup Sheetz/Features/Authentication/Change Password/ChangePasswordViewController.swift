//
//  ChangePasswordViewController.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 14/02/25.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var changePasswordLabel: UILabel!
    @IBOutlet weak var oldPasswordView: CustomTextFieldView!
    @IBOutlet weak var newPasswordView: CustomTextFieldView!
    @IBOutlet weak var confirmPasswordView: CustomTextFieldView!
    @IBOutlet weak var confirmButtonView: UIControl!
    
    var oldPassword = ""
    var newPassword = ""
    var confirmPassword = ""
    
    var viewModel = ChangePasswordViewModel(oldPassword: "", newPassword: "", confirmPassword: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        
        changePasswordLabel.text = "Change Password"
        changePasswordLabel.font = FontManager.customFont(weight: .medium, size: 24)
        
        configureTextField(oldPasswordView, icon: UIImage.passwordIcon, placeholder: "Old Password", textfieldType: .changeOldPassword,trailingIcon: UIImage(systemName: "eye.slash"))
        configureTextField(newPasswordView, icon: UIImage.passwordIcon, placeholder: "New Password", textfieldType: .changeNewPassword,trailingIcon: UIImage(systemName: "eye.slash"))
        configureTextField(confirmPasswordView, icon: UIImage.passwordIcon, placeholder: "Confirm New Password", textfieldType: .changeConfirmPassword,trailingIcon: UIImage(systemName: "eye.slash"))
        
        confirmButtonView.layer.cornerRadius = 16
        confirmButtonView.dropShadow()
    }
    
    func configureTextField(_ view: CustomTextFieldView, icon: UIImage?, placeholder: String, textfieldType: TextFieldType,trailingIcon: UIImage? = nil) {
        let textFieldView = Bundle.main.loadNibNamed("CustomTextFieldView", owner: self, options: nil)?.first as? CustomTextFieldView
        textFieldView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textFieldView?.setupView()
        textFieldView?.frame = view.bounds
        textFieldView?.delegateTextfieldType = textfieldType
        textFieldView?.delegateTextField = self
        textFieldView?.configure(icon: icon, placeholder: placeholder, fontWeight: .light, fontSize: 14, trailingIcon: trailingIcon)
        view.addSubview(textFieldView!)
    }
    
    @IBAction func didClickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickConfirmButton(_ sender: UIControl) {
        changePassword() 
    }
}

extension ChangePasswordViewController: DelegateTextField {
    func didChangeTextField(with text: String, and type: TextFieldType) {
        switch type {
        case .changeOldPassword:
            oldPassword = text
            break
        case .changeNewPassword:
            newPassword = text
            break
        case .changeConfirmPassword:
            confirmPassword = text
            break
        default:
            break
        }
    }
}

//MARK: - VIEWMODEL INTERACTIONS
extension ChangePasswordViewController {
    private func changePassword() {
        viewModel = ChangePasswordViewModel(
            oldPassword: oldPassword.trimmingCharacters(in: .whitespacesAndNewlines),
            newPassword: newPassword.trimmingCharacters(in: .whitespacesAndNewlines),
            confirmPassword: confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        viewModel.validate { result in
            switch result {
            case .success(_):
                self.viewModel.changePassword { result in
                    switch result {
                    case .success(let message):
                        self.showOKAlert(with: "Success", and: message) { alert in
                            self.navigationController?.popViewController(animated: false)
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
