//
//  SignUpViewController.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var BackgroundRounded: CustomViewCornerRounded!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var SignUpButton: CustomButton!
    @IBOutlet weak var LoginButton: CustomButton!
    
    weak var showPasswordButton: UIButton!
    var showImageUsername: UIImageView!
    var showImageEmail: UIImageView!
    var showImagePassword: UIImageView!
    
    var bottomLineUsername = CALayer()
    var bottomLineEmail = CALayer()
    var bottomLinePassword = CALayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }
    
    @objc func showButtonTapped(_ sender: Any){
        let isSecureTextEnty = !PasswordTextField.isSecureTextEntry
        PasswordTextField.isSecureTextEntry = isSecureTextEnty
        if #available(iOS 13.0, *){
            showPasswordButton.setImage(isSecureTextEnty ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
            showPasswordButton.tintColor = UIColor(named: "ButtonNoClick")
        } 
    }
    
    func setup() {
        UsernameTextField.delegate = self
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
        
        let iconContainerUsername = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        let imageUsernameView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
        imageUsernameView.image = UIImage(systemName: "person")
        imageUsernameView.contentMode = .scaleAspectFit
        imageUsernameView.tintColor = UIColor(named: "ButtonNoClick")
        iconContainerUsername.addSubview(imageUsernameView)
        UsernameTextField.leftViewMode = .always
        UsernameTextField.leftView = iconContainerUsername
        UsernameTextField.clearButtonMode = .always
        self.showImageUsername = imageUsernameView
        
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        let imageEmailView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
        imageEmailView.image = UIImage(systemName: "envelope")
        imageEmailView.contentMode = .scaleAspectFit
        imageEmailView.tintColor = UIColor(named: "ButtonNoClick")
        iconContainer.addSubview(imageEmailView)
        EmailTextField.leftViewMode = .always
        EmailTextField.leftView = iconContainer
        EmailTextField.clearButtonMode = .always
        self.showImageEmail = imageEmailView
        
        let iconContainerPassword = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        let imagePasswordView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
        imagePasswordView.image = UIImage(systemName: "lock")
        imagePasswordView.contentMode = .scaleAspectFit
        imagePasswordView.tintColor = UIColor(named: "ButtonNoClick")
        iconContainerPassword.addSubview(imagePasswordView)
        PasswordTextField.leftViewMode = .always
        PasswordTextField.leftView = iconContainerPassword
        PasswordTextField.clearButtonMode = .always
        self.showImagePassword = imagePasswordView
        
        
        let buttonHiddenPassword = UIButton(type: .system)
        buttonHiddenPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        buttonHiddenPassword.tintColor = UIColor(named: "ButtonNoClick")
        buttonHiddenPassword.addTarget(self, action: #selector(self.showButtonTapped(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            buttonHiddenPassword.heightAnchor.constraint(equalToConstant: 54),
            buttonHiddenPassword.widthAnchor.constraint(equalToConstant: 54),
            
        ])
        
        PasswordTextField.rightView = buttonHiddenPassword
        PasswordTextField.rightViewMode = .always
        self.showPasswordButton = buttonHiddenPassword
        
        bottomLineUsername.frame = CGRectMake(
            0,
            UsernameTextField.frame.height - 1,
            UsernameTextField.frame.width,
            1.0
        )
        
        bottomLineEmail.frame = CGRectMake(
            0,
            EmailTextField.frame.height - 1,
            EmailTextField.frame.width,
            1.0
        )
        
        bottomLinePassword.frame = CGRectMake(
            0,
            PasswordTextField.frame.height - 1,
            PasswordTextField.frame.width,
            1.0
        )
    
        bottomLineUsername.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
        UsernameTextField.layer.addSublayer(bottomLineUsername)
        
        bottomLineEmail.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
        EmailTextField.layer.addSublayer(bottomLineEmail)
        
        bottomLinePassword.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
        PasswordTextField.layer.addSublayer(bottomLinePassword)
        
//        SignUpButton.addTarget(self, action: #selector(handleClickButtonTapped), for: .touchUpInside)
        SignUpButton.backgroundColor = (UIColor(named: "ButtonNoClick"))
        SignUpButton.tintColor = UIColor.lightGray
//        SignUpButton.isEnabled = false
        
        //add shadow to background rounded
        BackgroundRounded.dropShadow()
        
        let los = "Already have an account? Let’s"
        let lis = "Login"

        let loginText = NSMutableAttributedString(
            string: "\(los) \(lis)",
            attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
            .foregroundColor: UIColor.black
        ])
        
        loginText.addAttributes([
            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
            .foregroundColor: UIColor.lightGray,
        ], range: NSString(string: loginText.string).range(of: los))

        loginText.addAttributes([
            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
            .foregroundColor: UIColor(named: "primary")!,
        ], range: NSString(string: loginText.string).range(of: lis))
        
        LoginButton.setAttributedTitle(loginText, for: .normal)
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        if (UsernameTextField.text?.isEmpty)! || (EmailTextField.text?.isEmpty)! || (PasswordTextField.text?.isEmpty)!{
            displayMessage(userMessage: "All fields are required! 🥺", title: "Sign Up")
        }
        
        guard let url = URL(string: Constants.signUpUrl) else {
                return
        }
        
        let username: String = UsernameTextField.text!
        let email: String = EmailTextField.text!
        let password: String = PasswordTextField.text!
        
        let data: Data = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8)!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
        request.httpBody = data
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            let responseSignUp = (response as? HTTPURLResponse)!
            if let error = error{
                print(error)
            }
            else if (response != nil) {
                print("her in response")
                print(response!)
            }else if let data = data{
                
                print("here in data")
                print(data)
            }
            
            DispatchQueue.main.async { [self] in
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                print(String(data: responseData, encoding: .utf8) ?? "")
                print(responseSignUp.statusCode)
                if(responseSignUp.statusCode == 200){
                    
                    self.view.endEditing(true)
                    
                    showImageUsername.tintColor = UIColor(named: "ButtonNoClick")
                    bottomLineUsername.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
                    UsernameTextField.layer.addSublayer(bottomLineUsername)
                    
                    showImageEmail.tintColor = UIColor(named: "ButtonNoClick")
                    bottomLineEmail.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
                    EmailTextField.layer.addSublayer(bottomLineEmail)
                    
                    showImagePassword.tintColor = UIColor(named: "ButtonNoClick")
                    bottomLinePassword.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
                    PasswordTextField.layer.addSublayer(bottomLinePassword)
                    displayMessageSignUp(userMessage: "Are you sure want to sign Up ? 😍", title: "Sign Up")
                    

                } else if(responseSignUp.statusCode == 401){
                    displayMessage(userMessage: "Email has been used. Please try with another email", title: "Sign Up")
                }
                
                
            }
        })
        task.resume()
    }
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView){
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func displayMessage(userMessage: String, title: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                print("OK button tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func displayMessageSignUp(userMessage: String, title: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                self.UsernameTextField.text = ""
                self.EmailTextField.text = ""
                self.PasswordTextField.text = ""
                self.showOtpViewPage()
            }
            
            let CancelAction = UIAlertAction(title: "Cancel", style: .default) {
                (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OKAction)
            alertController.addAction(CancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @objc private func handleClickButtonTapped() {

       let alertController = UIAlertController(title: "Sign Up", message: "Are you sure that you want to Sign Up?", preferredStyle: .alert)

       // adding actions to alert
       alertController.addAction(UIAlertAction(title: "Yes", style: .default))
       alertController.addAction(UIAlertAction(title: "Not now", style: .default))

       // present the alert on the screen
       self.present(alertController, animated: true)
    }
    
    @IBAction func LoginPage(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension SignUpViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        if textField == UsernameTextField {
            if text.isUsername && (PasswordTextField.text ?? "").isPassword && (EmailTextField.text ?? "").isEmail {
                SignUpButton.backgroundColor = UIColor(named: "primary")
                SignUpButton.tintColor = UIColor.white
                SignUpButton.isEnabled = true
            } else {
                SignUpButton.backgroundColor = UIColor(named: "ButtonNoClick")
                SignUpButton.tintColor = UIColor.lightGray
                SignUpButton.isEnabled = false
            }
        } else if textField == PasswordTextField {
            if text.isPassword && (EmailTextField.text ?? "").isEmail && (UsernameTextField.text ?? "").isUsername {
                SignUpButton.backgroundColor = UIColor(named: "primary")
                SignUpButton.tintColor = UIColor.white
                SignUpButton.isEnabled = true
            } else {
                SignUpButton.backgroundColor = UIColor(named: "ButtonNoClick")
                SignUpButton.tintColor = UIColor.lightGray
                SignUpButton.isEnabled = false
            }
        } else if textField == EmailTextField {
            if text.isEmail && (UsernameTextField.text ?? "").isUsername && (PasswordTextField.text ?? "").isPassword {
                SignUpButton.backgroundColor = UIColor(named: "primary")
                SignUpButton.tintColor = UIColor.white
                SignUpButton.isEnabled = true
            } else {
                SignUpButton.backgroundColor = UIColor(named: "ButtonNoClick")
                SignUpButton.tintColor = UIColor.lightGray
                SignUpButton.isEnabled = false
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case UsernameTextField:
            showImageUsername.tintColor = UIColor(named: "primary")
            bottomLineUsername.backgroundColor = UIColor(named: "primary")?.cgColor
            UsernameTextField.layer.addSublayer(bottomLineUsername)
            
        case EmailTextField:
            showImageEmail.tintColor = UIColor(named: "primary")
            bottomLineEmail.backgroundColor = UIColor(named: "primary")?.cgColor
            EmailTextField.layer.addSublayer(bottomLineEmail)
        case PasswordTextField:
            showImagePassword.tintColor = UIColor(named: "primary")
            bottomLinePassword.backgroundColor = UIColor(named: "primary")?.cgColor
            PasswordTextField.layer.addSublayer(bottomLinePassword)
        default:
            break
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        
        case UsernameTextField:
            if !(UsernameTextField.text ?? "").isEmpty {
                showImageUsername.tintColor = UIColor(named: "primary")
                bottomLineUsername.backgroundColor = UIColor(named: "primary")?.cgColor
                UsernameTextField.layer.addSublayer(bottomLineUsername)
            }else{
                showImageUsername.tintColor = UIColor(named: "ButtonNoClick")
                bottomLineUsername.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
                UsernameTextField.layer.addSublayer(bottomLineUsername)
            }
        case EmailTextField:
            if !(EmailTextField.text ?? "").isEmpty {
                showImageEmail.tintColor = UIColor(named: "primary")
                bottomLineEmail.backgroundColor = UIColor(named: "primary")?.cgColor
                EmailTextField.layer.addSublayer(bottomLineEmail)
            }else{
                showImageEmail.tintColor = UIColor(named: "ButtonNoClick")
                bottomLineEmail.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
                EmailTextField.layer.addSublayer(bottomLineEmail)
            }
                
        case PasswordTextField:
            if !(PasswordTextField.text ?? "").isEmpty {
                showImagePassword.tintColor = UIColor(named: "primary")
                bottomLinePassword.backgroundColor = UIColor(named: "primary")?.cgColor
                PasswordTextField.layer.addSublayer(bottomLinePassword)
            }else{
                showImagePassword.tintColor = UIColor(named: "ButtonNoClick")
                bottomLinePassword.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
                PasswordTextField.layer.addSublayer(bottomLinePassword)
            }
        default:
            break
        }
    }
}


extension UIViewController {
    func showSignUpViewController(){
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUp")
        navigationController?.pushViewController(viewController, animated: true)
    }
}
