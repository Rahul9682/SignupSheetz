//
//  RegisterViewController.swift
//  Signup Sheetz
//
//  Created by Braintech on 28/01/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Outlet's
    @IBOutlet weak var firstNametext: CustomTextFieldView!
    @IBOutlet weak var emailtext: CustomTextFieldView!
    @IBOutlet weak var lastNametext: CustomTextFieldView!
    @IBOutlet weak var phoneNumbertext: CustomTextFieldView!
    @IBOutlet weak var passwordtext: CustomTextFieldView!
    @IBOutlet weak var workTypetext: CustomTextFieldView!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var signUpButtonView: UIView!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confiqureUI()
      
    }
    
    private func configureEmailView(view: CustomTextFieldView, icon: UIImage?, placeholder: String) {
        let textFieldView = Bundle.main.loadNibNamed("CustomTextFieldView", owner: self, options: nil)?.first as? CustomTextFieldView
        textFieldView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textFieldView?.setupView()
        textFieldView?.frame = view.bounds
        textFieldView?.configure(icon: icon, placeholder: placeholder,fontWeight: .light, fontSize: 14)
        view.addSubview(textFieldView!)
    }
    
    func confiqureUI() {
        pageTitleLabel.text = "Sign Up"
        pageTitleLabel.font = FontManager.customFont(weight: .medium, size: 24)
        configureEmailView(view: firstNametext,icon: UIImage.profileIcon,placeholder: "First Name")
        configureEmailView(view: lastNametext,icon: UIImage.profileIcon,placeholder: "Last Name")
        
        configureEmailView(view: phoneNumbertext,icon: UIImage.phone,placeholder: "Phone Number")
        configureEmailView(view: emailtext,icon: UIImage.mail,placeholder: "abc@email.com")
        configureEmailView(view: passwordtext,icon: UIImage.passwordIcon,placeholder: "Password")
        configureEmailView(view: workTypetext,icon: UIImage.work,placeholder: "Select Individual / Organization")
        signUpButtonView.layer.cornerRadius = 16
        signUpButtonView.dropShadow()
        alreadyHaveAccountLabel.font = FontManager.customFont(weight: .book, size: 15)
        let fullText = "Already have an account? Sign In"
        let customColor = UIColor(red: 206/255, green: 189/255, blue: 14/255, alpha: 1.0)
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "Sign In")
        attributedString.addAttribute(.foregroundColor, value:customColor , range: range)
        alreadyHaveAccountLabel.attributedText = attributedString
        alreadyHaveAccountLabel.textAlignment = .center
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
