//
//  EditProfileViewController.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 14/02/25.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var firstNameView: CustomTextFieldView!
    @IBOutlet weak var lastNameView: CustomTextFieldView!
    @IBOutlet weak var organizationTypeView: CustomTextFieldView!
    @IBOutlet weak var emailView: CustomTextFieldView!
    @IBOutlet weak var phoneView: CustomTextFieldView!
    @IBOutlet weak var updateButtonView: UIView!
    
    var firstNameText = ""
    var lastNameText = ""
    var phoneText = ""
    var emailText = ""
    var organizationText = ""
    
    var userData: LoginUserData?
    var viewModel = EditProfileViewModel(firstName: "", lastName: "", phone: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        if let userData = self.userData {
            firstNameText = userData.firstName ?? ""
            lastNameText = userData.lastName ?? ""
            phoneText = userData.phone ?? ""
            emailText = userData.email ?? ""
            organizationText = userData.organizationType ?? ""
        }
        
        updateLabel.text = "Update Profile"
        updateLabel.font = FontManager.customFont(weight: .medium, size: 24)
        
        configureTextField(firstNameView, icon: UIImage.profileIcon, placeholder: "First Name", textfieldType: .updateProfileFirstName, text: firstNameText)
        configureTextField(lastNameView, icon: UIImage.profileIcon, placeholder: "Last Name", textfieldType: .updateProfileLastName, text: lastNameText)
        configureTextField(emailView, icon: UIImage.mail, placeholder: "abc@email.com", textfieldType: .signupEmail, editable: false, text: emailText)
        configureTextField(organizationTypeView, icon: UIImage.work, placeholder: "abc@email.com", textfieldType: .signupWorkType, editable: false, text: organizationText)
        configureTextField(phoneView, icon: UIImage.phone, placeholder: "Phone Number", textfieldType: .updateProfilePhone, text: phoneText)
        
        updateButtonView.layer.cornerRadius = 16
        updateButtonView.dropShadow()
    }
    
    func configureTextField(_ view: CustomTextFieldView, icon: UIImage?, placeholder: String, textfieldType: TextFieldType,trailingIcon: UIImage? = nil, editable: Bool = true, text: String?) {
        let textFieldView = Bundle.main.loadNibNamed("CustomTextFieldView", owner: self, options: nil)?.first as? CustomTextFieldView
        textFieldView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textFieldView?.setupView()
        textFieldView?.frame = view.bounds
        textFieldView?.delegateTextfieldType = textfieldType
        textFieldView?.delegateTextField = self
        textFieldView?.configure(icon: icon, placeholder: placeholder, fontWeight: .light, fontSize: 14, trailingIcon: trailingIcon, editable: editable, text: text)
        view.addSubview(textFieldView!)
    }
    
    @IBAction func didClickUpdateButton(_ sender: UIButton) {
        editProfile()
    }
    
    @IBAction func didClickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickChangePassword(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension EditProfileViewController: DelegateTextField {
    func didChangeTextField(with text: String, and type: TextFieldType) {
        switch type {
        case .updateProfileFirstName:
            firstNameText = text
            break
        case .updateProfileLastName:
            lastNameText = text
            break
        case .updateProfilePhone:
            phoneText = text
            break
        default:
            break
        }
    }
}

//MARK: - VIEWMODEL INTERACTIONS
extension EditProfileViewController {
    private func editProfile() {
        viewModel = EditProfileViewModel(
            firstName: firstNameText.trimmingCharacters(in: .whitespacesAndNewlines),
            lastName: lastNameText.trimmingCharacters(in: .whitespacesAndNewlines),
            phone: phoneText.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        viewModel.validate { result in
            switch result {
            case .success(_):
                self.viewModel.editProfile { result in
                    switch result {
                    case .success(let message):
                        self.showOKAlert(with: "Success", and: message) { alert in
                            // self.navigationController?.popViewController(animated: false)
                            let tabBarController = CustomTabBarController()
                            tabBarController.modalPresentationStyle = .fullScreen
                            self.navigationController?.pushViewController(tabBarController, animated: false)
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
