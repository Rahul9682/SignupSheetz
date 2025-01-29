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
    
    private var viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
     
    }
    
    // MARK: - UI Configuration
    func configureUI() {
        pageTitleLabel.text = "Sign Up"
        pageTitleLabel.font = FontManager.customFont(weight: .medium, size: 24)

        configureTextField(firstNametext, icon: UIImage.profileIcon, placeholder: "First Name")
        configureTextField(lastNametext, icon: UIImage.profileIcon, placeholder: "Last Name")
        configureTextField(phoneNumbertext, icon: UIImage.phone, placeholder: "Phone Number")
        configureTextField(emailtext, icon: UIImage.mail, placeholder: "abc@email.com")
        configureTextField(passwordtext, icon: UIImage.passwordIcon, placeholder: "Password")
        configureTextField(workTypetext, icon: UIImage.work, placeholder: "Select Individual / Organization")
        
        signUpButtonView.layer.cornerRadius = 16
        signUpButtonView.dropShadow()
        
        alreadyHaveAccountLabel.font = FontManager.customFont(weight: .book, size: 15)
        setupSignInLabel()
    }
    
    func configureTextField(_ view: CustomTextFieldView, icon: UIImage?, placeholder: String) {
        let textFieldView = Bundle.main.loadNibNamed("CustomTextFieldView", owner: self, options: nil)?.first as? CustomTextFieldView
        textFieldView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textFieldView?.setupView()
        textFieldView?.frame = view.bounds
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
        var signupData: SignupData?
        signupData?.firstName = firstNametext.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        signupData?.lastName = lastNametext.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        signupData?.email = emailtext.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        signupData?.phone = phoneNumbertext.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        signupData?.password = passwordtext.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        signupData?.confirmPassword = passwordtext.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//        signupData?.organizationType = firstNametext.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        viewModel = RegisterViewModel(signupData: signupData)
        self.viewModel.userRegister { result in
            switch result {
            case .success(let message):
                print(message)
                //                self.showToast(with: message, toastType: .success)
                //                if let successDelegateToRootVC = self.successDelegateToRootVC {
                //                    successDelegateToRootVC.onSuccess(with: self.index)
                //                }
                //                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                break
                //                self.showToast(with: error.localizedDescription, toastType: .error)
            }
        }
        
    }
}
