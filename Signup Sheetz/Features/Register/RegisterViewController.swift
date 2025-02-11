//
//  ViewController.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 23/01/25.
//

import UIKit
import DropDown

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
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var selectedText: UITextField!
    
    
    //MARK: - Properties
    private var viewModel = RegisterViewModel()
    var firstName = ""
    var lastName = ""
    var workType = ""
    var email = ""
    var phone = ""
    var password = ""
    var dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDropDownUI()
    }
    
    // MARK: - UI Configuration
    func configureUI() {
        pageTitleLabel.text = "Sign Up"
        pageTitleLabel.font = FontManager.customFont(weight: .medium, size: 24)
        
        configureTextField(firstNametext, icon: UIImage.profileIcon, placeholder: "First Name", textfieldType: .signupFirstName)
        configureTextField(lastNametext, icon: UIImage.profileIcon, placeholder: "Last Name", textfieldType: .signupLastName)
        configureTextField(phoneNumbertext, icon: UIImage.phone, placeholder: "Phone Number", textfieldType: .signupPhoneNumber)
        configureTextField(emailtext, icon: UIImage.mail, placeholder: "abc@email.com", textfieldType: .signupEmail)
        configureTextField(passwordtext, icon: UIImage.passwordIcon, placeholder: "Password", textfieldType: .signupPassword,trailingIcon: UIImage(systemName: "eye.slash"))
        // configureTextField(workTypetext, icon: UIImage.work, placeholder: "Select Individual / Organization", textfieldType: .signupWorkType)
      
        signUpButtonView.layer.cornerRadius = 16
        signUpButtonView.dropShadow()
        
        dropDownView.layer.cornerRadius = 10
        dropDownView.layer.borderWidth = 1
        dropDownView.layer.borderColor = UIColor.lightGray.cgColor
        dropDown.layer.masksToBounds = true
        
        alreadyHaveAccountLabel.font = FontManager.customFont(weight: .book, size: 15)
        setupSignInLabel()
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
    
    
    func configureDropDownUI() {
        dropDownView.layer.cornerRadius = 10
        dropDown.anchorView = dropDownView
        dropDown.bounds = CGRect(x: 0, y: dropDownView.frame.height - 100, width: dropDownView.frame.width - 100,height:0)
        dropDown.width = dropDownView.bounds.width - 20
        dropDown.cornerRadius = 4
        dropDown.backgroundColor = .white
        dropDown.separatorColor = .white
        dropDown.customCellConfiguration = { (index: Int, item: String, cell: DropDownCell) in
            cell.optionLabel.textAlignment = .center // Change to .left or .right if needed
        }
        dropDown.dataSource = ["Individual", "Organization"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedText.text = item
            self.workType = item
        }
        
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
    
    
    @IBAction func showDropDownAction(_ sender: Any) {
        dropDown.show()
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
            workType = ""
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
