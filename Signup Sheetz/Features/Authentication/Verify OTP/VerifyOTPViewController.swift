//
//  VerifyOTPViewController.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 11/02/25.
//

import UIKit

class VerifyOTPViewController: UIViewController {
    
    @IBOutlet weak var sendButtonView: UIView!
    @IBOutlet weak var goBackLabel: UILabel!
    @IBOutlet weak var verifyDescriptionLabel: UILabel!
    @IBOutlet weak var otpTextfield1: UITextField!
    @IBOutlet weak var otpTextfield2: UITextField!
    @IBOutlet weak var otpTextfield3: UITextField!
    @IBOutlet weak var otpTextfield4: UITextField!
    @IBOutlet weak var disclaimerLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    //MARK: - Properties
    var otp = ""
    var email = ""
    private var viewModel = VerifyOTPViewModel(email: "", otp: "")
    
    var timer: Timer?
    var totalTime = 120

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        sendButtonView.layer.cornerRadius = 16
        sendButtonView.dropShadowForSocialLogin()
        goBackLabel.font = FontManager.customFont(weight: .book, size: 15)
        
        let fullText = "Go back to Previous page"
        let customColor = UIColor(red: 206/255, green: 189/255, blue: 14/255, alpha: 1.0)
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "Previous page")
        attributedString.addAttribute(.foregroundColor, value:customColor , range: range)
        goBackLabel.attributedText = attributedString
        
        let fullDescription = "A 4-digit verification code has been sent to you via \(self.email) , Please enter that to verify your email."
        let emailTextColor = UIColor(red: 206/255, green: 189/255, blue: 14/255, alpha: 1.0)
        let attributedDescription = NSMutableAttributedString(string: fullDescription)
        let descriptionRange = (fullDescription as NSString).range(of: "\(self.email)")
        attributedDescription.addAttribute(.foregroundColor, value: emailTextColor , range: descriptionRange)
        verifyDescriptionLabel.attributedText = attributedDescription
        verifyDescriptionLabel.font = FontManager.customFont(weight: .book, size: 15)
        
        let fullDisclaimer = "Can't Find Code?\nIf you do not see the email within few minutes, check your 'junk mail' folder or 'spam' folder. We make evry effort to ensure that these emails to be delivered."
        let disclaimerTextColor = UIColor(red: 206/255, green: 189/255, blue: 14/255, alpha: 1.0)
        let attributedDisclaimer = NSMutableAttributedString(string: fullDisclaimer)
        let disclaimerRange = (fullDisclaimer as NSString).range(of: "Can't Find Code?")
        attributedDisclaimer.addAttribute(.foregroundColor, value: disclaimerTextColor , range: disclaimerRange)
        disclaimerLabel.attributedText = attributedDisclaimer
        disclaimerLabel.font = FontManager.customFont(weight: .book, size: 15)
        
        otpTextfield1.delegate = self
        otpTextfield2.delegate = self
        otpTextfield3.delegate = self
        otpTextfield4.delegate = self
        
        otpTextfield1.layer.borderColor = UIColor.black.cgColor
        otpTextfield2.layer.borderColor = UIColor.black.cgColor
        otpTextfield3.layer.borderColor = UIColor.black.cgColor
        otpTextfield4.layer.borderColor = UIColor.black.cgColor
        otpTextfield1.layer.cornerRadius = 8
        otpTextfield2.layer.cornerRadius = 8
        otpTextfield3.layer.cornerRadius = 8
        otpTextfield4.layer.cornerRadius = 8
        otpTextfield1.layer.borderWidth = 1
        otpTextfield2.layer.borderWidth = 1
        otpTextfield3.layer.borderWidth = 1
        otpTextfield4.layer.borderWidth = 1
        
        self.otpTextfield1.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.otpTextfield2.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.otpTextfield3.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.otpTextfield4.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyBoard))
//        view.addGestureRecognizer(tap)
    }
    
    @objc func changeCharacter(textField : UITextField) {
        if textField.text?.utf8.count == 1 {
            switch textField {
            case otpTextfield1:
                otpTextfield2.becomeFirstResponder()
            case otpTextfield2:
                otpTextfield3.becomeFirstResponder()
            case otpTextfield3:
                otpTextfield4.becomeFirstResponder()
            case otpTextfield4:
                otpTextfield4.resignFirstResponder()
                self.otp = "\(otpTextfield1.text!)\(otpTextfield2.text!)\(otpTextfield3.text!)\(otpTextfield4.text!)"
                print("OTP = \(otpTextfield1.text!)\(otpTextfield2.text!)\(otpTextfield3.text!)\(otpTextfield4.text!)")
            default:
                break
            }
        } else if textField.text!.isEmpty {
            switch textField {
            case otpTextfield4:
                otpTextfield3.becomeFirstResponder()
            case otpTextfield3:
                otpTextfield2.becomeFirstResponder()
            case otpTextfield2:
                otpTextfield1.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        totalTime = 120
        updateTimerLabel()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if totalTime > 0 {
            totalTime -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
            timerLabel.text = "Resend OTP"
            print("Timer finished! You can resend OTP now.")
        }
    }
    
    func updateTimerLabel() {
        let minutes = totalTime / 60
        let seconds = totalTime % 60
        timerLabel.text = "Request a new code in \(String(format: "%02d:%02d", minutes, seconds))"
    }
    
    @IBAction func didClickSendButtonForVerifyOTP(_ sender: UIControl) {
        verifyOTP()
    }
    
    @IBAction func didClickResendOTP(_ sender: UIControl) {
        if totalTime == 0 {
            resendOTP()
        }
    }
    
    @IBAction func didClickGoBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension VerifyOTPViewController :UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.utf16.count == 1 && !string.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == otpTextfield1 {
            otpTextfield1.layer.borderWidth = 2
            otpTextfield2.layer.borderWidth = 1
            otpTextfield3.layer.borderWidth = 1
            otpTextfield4.layer.borderWidth = 1
        } else if textField == otpTextfield2 {
            otpTextfield1.layer.borderWidth = 1
            otpTextfield2.layer.borderWidth = 2
            otpTextfield3.layer.borderWidth = 1
            otpTextfield4.layer.borderWidth = 1
        } else if textField == otpTextfield3 {
            otpTextfield1.layer.borderWidth = 1
            otpTextfield2.layer.borderWidth = 1
            otpTextfield3.layer.borderWidth = 2
            otpTextfield4.layer.borderWidth = 1
        } else if textField == otpTextfield4 {
            otpTextfield1.layer.borderWidth = 1
            otpTextfield2.layer.borderWidth = 1
            otpTextfield3.layer.borderWidth = 1
            otpTextfield4.layer.borderWidth = 2
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == otpTextfield1 {
            otpTextfield1.layer.borderWidth = 1
        } else if textField == otpTextfield2 {
            otpTextfield2.layer.borderWidth = 1
        } else if textField == otpTextfield3 {
            otpTextfield3.layer.borderWidth = 1
        } else if textField == otpTextfield4 {
            otpTextfield4.layer.borderWidth = 1
        }
    }
    
}

//MARK: - VIEWMODEL INTERACTIONS
extension VerifyOTPViewController {
    private func verifyOTP() {
        viewModel = VerifyOTPViewModel(email: self.email, otp: self.otp)
        viewModel.validation { result in
            switch result {
            case .success(_):
                self.viewModel.verifyOTP { result in
                    switch result {
                    case .success(let message):
                        
                        print("success :: \(message)")
                        self.showOKAlert(with: "Success", and: "OTP Verified successfully, Click OK to reset your password") { alert in
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
                            vc.email = self.email.trimmingCharacters(in: .whitespacesAndNewlines)
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
    
    func resendOTP() {
        viewModel = VerifyOTPViewModel(email: self.email, otp: self.otp)
        viewModel.resendOTP { result in
            switch result {
            case .success(let message):
                print("success :: \(message)")
                self.startTimer()
                
            case .failure(let error):
                self.showOKAlert(with: "Error", and: error.localizedDescription) { alert in
                    self.resendOTP()
                }
            }
        }
    }
}
