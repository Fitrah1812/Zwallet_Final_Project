//
//  ViewController.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundRounded: CustomViewCornerRounded!
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var ForgotButton: UIButton!
    @IBOutlet weak var ValidationLabel: UILabel!
    @IBOutlet weak var LoginButton: CustomButton!
    @IBOutlet weak var SignUpButton: CustomButton!
    
    weak var showPasswordButton: UIButton!
    var showImageEmail: UIImageView!
    var showImagePassword: UIImageView!
    var bearerTokenFromLogin: String = ""
    
    var bottomLineEmail = CALayer()
    var bottomLinePassword = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func showButtonTapped(_ sender: Any){
        let isSecureTextEnty = !PasswordTextField.isSecureTextEntry
        PasswordTextField.isSecureTextEntry = isSecureTextEnty
        if #available(iOS 13.0, *){
            showPasswordButton.setImage(isSecureTextEnty ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
            showPasswordButton.tintColor = UIColor(named: "ButtonNoClick")
        } else{
            
        }
    }
    
    func setup(){
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
        
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
        
        bottomLineEmail.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
        EmailTextField.layer.addSublayer(bottomLineEmail)
        
        bottomLinePassword.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
        PasswordTextField.layer.addSublayer(bottomLinePassword)
        
        LoginButton.backgroundColor = (UIColor(named: "ButtonNoClick"))
        LoginButton.tintColor = UIColor.lightGray
        //        LoginButton.isEnabled = false
        
        ForgotButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        //add shadow to background rounded
        backgroundRounded.dropShadow()
        
        let los = "Dont't have an account? Let's"
        let lis = "Sign Up"
        
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
        
        SignUpButton.setAttributedTitle(loginText, for: .normal)
        
    }
    
    @IBAction func PageForgotPassword(_ sender: Any) {
        showResetPasswordController()
    }
    @IBAction func PageSignUp(_ sender: Any) {
        showSignUpViewController()
    }
    @IBAction func HomePage(_ sender: Any) {
        showHomeController()
    }
    
    func displayMessage(userMessage: String, title: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func displayMessageLogin(userMessage: String, title: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                print("OK button tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
               
            }
            
            let CancelAction = UIAlertAction(title: "Cancel", style: .default) {
                (action:UIAlertAction!) in
                print("OK button tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OKAction)
            alertController.addAction(CancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        if(EmailTextField.text?.isEmpty)! || (PasswordTextField.text?.isEmpty)! {
            displayMessage(userMessage: "All fields are required! 😭", title: "Login")
        }
        
        let email: String = EmailTextField.text!
        let password: String = PasswordTextField.text!
        
        let url = URL(string: Constants.loginUrl)!
        let data: Data = "email=\(email)&password=\(password)".data(using: .utf8)!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
        request.httpBody = data
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            let responseLogin = (response as? HTTPURLResponse)!
            
            if let error = error{
                print(error)
            }
            else if (response != nil) {
                print("Response Login")
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
                print(responseLogin.statusCode)
                
                if(responseLogin.statusCode == 200){
                    showImageEmail.tintColor = UIColor(named: "primary")
                    bottomLineEmail.backgroundColor = UIColor(named: "primary")?.cgColor
                    EmailTextField.layer.addSublayer(bottomLineEmail)
                    
                    showImagePassword.tintColor = UIColor(named: "primary")
                    bottomLinePassword.backgroundColor = UIColor(named: "primary")?.cgColor
                    PasswordTextField.layer.addSublayer(bottomLinePassword)
                    
                    ValidationLabel.text = " "
                    
                    displayMessageLogin(userMessage: "Are you sure want to login? 🚀", title: "Login")
                    do {
                        let responseLoginModel = try JSONDecoder().decode(ResponseLogin.self, from: responseData)
                        bearerTokenFromLogin = responseLoginModel.data.token
                        UserDefaults.standard.set(responseData, forKey: "sessionPersonLogin")
                        UserDefaults.standard.setValue(bearerTokenFromLogin, forKey: "token")
                        
                    } catch let jsonErr {
                            print(jsonErr)
                    }
                    
                } else if(responseLogin.statusCode == 404){
//                    displayMessage(userMessage: "Email or Password Invalid", title: "Login")
                    self.view.endEditing(true)
                    showImageEmail.tintColor = UIColor.red
                    bottomLineEmail.backgroundColor = UIColor.red.cgColor
                    EmailTextField.layer.addSublayer(bottomLineEmail)
                    
                    showImagePassword.tintColor = UIColor.red
                    bottomLinePassword.backgroundColor = UIColor.red.cgColor
                    PasswordTextField.layer.addSublayer(bottomLinePassword)
                    
                    ValidationLabel.text = "Email or Password invalid"
                    ValidationLabel.textColor = UIColor.red
                    
                }
            }
        })
        task.resume()
    }
}


extension ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {

        switch textField {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        if textField == EmailTextField {
            if text.isEmail && (PasswordTextField.text ?? "").isPassword {
                LoginButton.backgroundColor = UIColor(named: "primary")
                LoginButton.tintColor = UIColor.white
                LoginButton.isEnabled = true
            } else {
                LoginButton.backgroundColor = UIColor(named: "ButtonNoClick")
                LoginButton.tintColor = UIColor.lightGray
                LoginButton.isEnabled = false
            }
        } else if textField == PasswordTextField {
            if text.isPassword && (EmailTextField.text ?? "").isEmail {
                LoginButton.backgroundColor = UIColor(named: "primary")
                LoginButton.tintColor = UIColor.white
                LoginButton.isEnabled = true
            } else {
                LoginButton.backgroundColor = UIColor(named: "ButtonNoClick")
                LoginButton.tintColor = UIColor.lightGray
                LoginButton.isEnabled = false
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
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

