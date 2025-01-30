//
//  ViewController.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 23/01/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var firstNametext: CustomTextFieldView!
    @IBOutlet weak var emailtext: CustomTextFieldView!
    @IBOutlet weak var lastNametext: CustomTextFieldView!
    @IBOutlet weak var phoneNumbertext: CustomTextFieldView!
    @IBOutlet weak var passwordtext: CustomTextFieldView!
    @IBOutlet weak var workTypetext: CustomTextFieldView!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var signUpButtonView: UIView!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    
    
    //MARK: - Properties
    private var viewModel = RegisterViewModel()
    var firstName = ""
    var lastName = ""
    var workType = ""
    var email = ""
    var phone = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
     
    }
    
    // MARK: - UI Configuration
    func configureUI() {
        pageTitleLabel.text = "Sign Up"
        pageTitleLabel.font = FontManager.customFont(weight: .medium, size: 24)

        configureTextField(firstNametext, icon: UIImage.profileIcon, placeholder: "First Name", textfieldType: .signupFirstName)
        configureTextField(lastNametext, icon: UIImage.profileIcon, placeholder: "Last Name", textfieldType: .signupLastName)
        configureTextField(phoneNumbertext, icon: UIImage.phone, placeholder: "Phone Number", textfieldType: .signupPhoneNumber)
        configureTextField(emailtext, icon: UIImage.mail, placeholder: "abc@email.com", textfieldType: .signupEmail)
        configureTextField(passwordtext, icon: UIImage.passwordIcon, placeholder: "Password", textfieldType: .signupPassword)
        configureTextField(workTypetext, icon: UIImage.work, placeholder: "Select Individual / Organization", textfieldType: .signupWorkType)
        
        signUpButtonView.layer.cornerRadius = 16
        signUpButtonView.dropShadow()
        
        alreadyHaveAccountLabel.font = FontManager.customFont(weight: .book, size: 15)
        setupSignInLabel()
    }
    
    func configureTextField(_ view: CustomTextFieldView, icon: UIImage?, placeholder: String, textfieldType: TextFieldType) {
        let textFieldView = Bundle.main.loadNibNamed("CustomTextFieldView", owner: self, options: nil)?.first as? CustomTextFieldView
        textFieldView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textFieldView?.setupView()
        textFieldView?.frame = view.bounds
        textFieldView?.delegateTextfieldType = textfieldType
        textFieldView?.delegateTextField = self
        textFieldView?.configure(icon: icon, placeholder: placeholder, fontWeight: .light, fontSize: 14)
        view.addSubview(textFieldView!)
    }
    
    func setupSignInLabel() {
        let fullText = "Already have an account? Sign In"
        let customColor = UIColor(red: 206/255, green: 189/255, blue: 14/255, alpha: 1.0)
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "Sign In")
        attributedString.addAttribute(.foregroundColor, value: customColor, range: range)
        alreadyHaveAccountLabel.attributedText = attributedString
        alreadyHaveAccountLabel.textAlignment = .center
    }
    
    // MARK: - Button Actions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    @IBAction func signUpAction(_ sender: Any) {
        userRegister()
    }
    
    // MARK: - Helper Method
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Signup", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

//MARK: - VIEWMODEL INTERACTIONS
extension RegisterViewController {
    private func userRegister() {
        var signupData = SignupData(firstName: firstName, lastName: lastName, organizationType: workType, email: email, phone: phone, password: password)
        viewModel = RegisterViewModel(signupData: signupData)
        
        
        viewModel.validate { result in
            switch result {
            case .success(_):
                self.viewModel.userRegister { result in
                    switch result {
                    case .success(let message):
                        
                        self.showOKAlert(with: "Success", and: message) { alert in
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

extension RegisterViewController: DelegateTextField {
    func didChangeTextField(with text: String, and type: TextFieldType) {
        switch type {
        case .signupFirstName:
            firstName = text
            break
        case .signupLastName:
            lastName = text
            break
        case .signupWorkType:
            workType = text
            break
        case .signupEmail:
            email = text
            break
        case .signupPhoneNumber:
            phone = text
            break
        case .signupPassword:
            password = text
            break
        default:
            break
        }
    }
}
