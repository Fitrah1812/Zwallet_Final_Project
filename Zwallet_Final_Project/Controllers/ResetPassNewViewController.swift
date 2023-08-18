//
//  ResetPassNewViewController.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit

class ResetPassNewViewController: UIViewController {

    @IBOutlet weak var BackgroundRounded: CustomViewCornerRounded!
    
    @IBOutlet weak var NewPasswordTextField: UITextField!
    @IBOutlet weak var NewConfirmTextField: UITextField!
    
    @IBOutlet weak var ConfirmPasswordButton: CustomButton!
    
    var emailTransfered: String = ""
    
    weak var showPasswordButton: UIButton!
    weak var showPasswordConfirmButton: UIButton!
    var showImagePassword: UIImageView!
    var showImagePasswordConfirm: UIImageView!
    
    var bottomLinePassword = CALayer()
    var bottomLinePasswordConfirm = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    @objc func showButtonTapped(_ sender: Any){
        let isSecureTextEnty = !NewPasswordTextField.isSecureTextEntry
        NewPasswordTextField.isSecureTextEntry = isSecureTextEnty
        if #available(iOS 13.0, *){
            showPasswordButton.setImage(isSecureTextEnty ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
            showPasswordButton.tintColor = UIColor(named: "ButtonNoClick")
        } else{
            
        }
    }
    
    @objc func showButtonTappedConfirm(_ sender: Any){
        let isSecureTextEnty = !NewConfirmTextField.isSecureTextEntry
        NewConfirmTextField.isSecureTextEntry = isSecureTextEnty
        if #available(iOS 13.0, *){
            showPasswordConfirmButton.setImage(isSecureTextEnty ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
            showPasswordConfirmButton.tintColor = UIColor(named: "ButtonNoClick")
        } else{
            
        }
    }
    
    func setup() {
        NewPasswordTextField.delegate = self
        NewConfirmTextField.delegate = self
        
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        let imagePasswordView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
        imagePasswordView.image = UIImage(systemName: "lock")
        imagePasswordView.contentMode = .scaleAspectFit
        imagePasswordView.tintColor = UIColor(named: "ButtonNoClick")
        iconContainer.addSubview(imagePasswordView)
        NewPasswordTextField.leftViewMode = .always
        NewPasswordTextField.leftView = iconContainer
        NewPasswordTextField.clearButtonMode = .always
        self.showImagePassword = imagePasswordView
        
        let iconContainerPasswordConfirm = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        let imagePasswordConfirmView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
        imagePasswordConfirmView.image = UIImage(systemName: "lock")
        imagePasswordConfirmView.contentMode = .scaleAspectFit
        imagePasswordConfirmView.tintColor = UIColor(named: "ButtonNoClick")
        iconContainerPasswordConfirm.addSubview(imagePasswordConfirmView)
        NewConfirmTextField.leftViewMode = .always
        NewConfirmTextField.leftView = iconContainerPasswordConfirm
        NewConfirmTextField.clearButtonMode = .always
        self.showImagePasswordConfirm = imagePasswordConfirmView
        
        
        let buttonHiddenPassword = UIButton(type: .system)
        buttonHiddenPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        buttonHiddenPassword.tintColor = UIColor(named: "ButtonNoClick")
        buttonHiddenPassword.addTarget(self, action: #selector(self.showButtonTapped(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            buttonHiddenPassword.heightAnchor.constraint(equalToConstant: 54),
            buttonHiddenPassword.widthAnchor.constraint(equalToConstant: 54),
            
        ])
        
        let buttonHiddenPasswordConfirm = UIButton(type: .system)
        buttonHiddenPasswordConfirm.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        buttonHiddenPasswordConfirm.tintColor = UIColor(named: "ButtonNoClick")
        buttonHiddenPasswordConfirm.addTarget(self, action: #selector(self.showButtonTappedConfirm(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            buttonHiddenPasswordConfirm.heightAnchor.constraint(equalToConstant: 54),
            buttonHiddenPasswordConfirm.widthAnchor.constraint(equalToConstant: 54),
            
        ])
        
        NewPasswordTextField.rightView = buttonHiddenPassword
        NewPasswordTextField.rightViewMode = .always
        self.showPasswordButton = buttonHiddenPassword
        
        NewConfirmTextField.rightView = buttonHiddenPasswordConfirm
        NewConfirmTextField.rightViewMode = .always
        self.showPasswordConfirmButton = buttonHiddenPasswordConfirm
        
        
        bottomLinePassword.frame = CGRectMake(
            0,
            NewPasswordTextField.frame.height - 1,
            NewPasswordTextField.frame.width,
            1.0
        )

        bottomLinePasswordConfirm.frame = CGRectMake(
            0,
            NewConfirmTextField.frame.height - 1,
            NewConfirmTextField.frame.width,
            1.0
        )
        
        bottomLinePasswordConfirm.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
        NewConfirmTextField.layer.addSublayer(bottomLinePasswordConfirm)
        
        bottomLinePassword.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
        NewPasswordTextField.layer.addSublayer(bottomLinePassword)
        
        ConfirmPasswordButton.backgroundColor = (UIColor(named: "ButtonNoClick"))
        ConfirmPasswordButton.tintColor = UIColor.lightGray
//        ConfirmPasswordButton.isEnabled = false
        
        //add shadow to background rounded
        BackgroundRounded.dropShadow()
    }
    
    @objc private func handleClickButtonTapped() {

       let alertController = UIAlertController(title: "Reset Passowrd", message: "Are you sure that you want to update password?", preferredStyle: .alert)

       // adding actions to alert
       alertController.addAction(UIAlertAction(title: "Yes", style: .default))
       alertController.addAction(UIAlertAction(title: "No", style: .default))

       // present the alert on the screen
       self.present(alertController, animated: true)
    }
    
    @IBAction func BackLoginPage(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func ConfirmButton(_ sender: Any) {
        if(NewPasswordTextField.text?.isEmpty)! || (NewConfirmTextField.text?.isEmpty)! {
            displayMessage(userMessage: "All field are required", title: "Reset Password")
        }
        if(NewPasswordTextField.text != NewConfirmTextField.text){
            self.view.endEditing(true)
            
            showImagePassword.tintColor = UIColor.red
            bottomLinePassword.backgroundColor = UIColor.red.cgColor
            NewPasswordTextField.layer.addSublayer(bottomLinePassword)
            
            showImagePasswordConfirm.tintColor = UIColor.red
            bottomLinePasswordConfirm.backgroundColor = UIColor.red.cgColor
            NewConfirmTextField.layer.addSublayer(bottomLinePasswordConfirm)
            
            displayMessage(userMessage: "The password confirmation does not match", title: "Reset Password")
        }
        
        let email: String = emailTransfered
        let password: String = NewPasswordTextField.text!
        
        let url = URL(string: Constants.resetPass)!
        let data: Data = "email=\(email)&password=\(password)".data(using: .utf8)!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "PATCH"
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
                print("her in response")
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
                    displayMessageReset(userMessage: "Congratulations, Reset password has been success 🎉 ", title: "Login")
//                    navigationController?.popToRootViewController(animated: true)
                } else if(responseLogin.statusCode == 404){
//                    displayMessage(userMessage: "Email or Password Invalid", title: "Login")
                    self.view.endEditing(true)
                   
                }
            }
        })
        task.resume()
        
    }
    
    func displayMessageReset(userMessage: String, title: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                print("OK button tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                self.navigationController?.popToRootViewController(animated: true)
            }
                        
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
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
}



extension ResetPassNewViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        if textField == NewPasswordTextField {
            if text.isPassword && (NewConfirmTextField.text ?? "").isPassword  {
                ConfirmPasswordButton.backgroundColor = UIColor(named: "primary")
                ConfirmPasswordButton.tintColor = UIColor.white
                ConfirmPasswordButton.isEnabled = true
            } else {
                ConfirmPasswordButton.backgroundColor = UIColor(named: "ButtonNoClick")
                ConfirmPasswordButton.tintColor = UIColor.lightGray
                ConfirmPasswordButton.isEnabled = false
            }
        } else if textField == NewConfirmTextField {
            if text.isPassword && (NewPasswordTextField.text ?? "").isPassword {
                ConfirmPasswordButton.backgroundColor = UIColor(named: "primary")
                ConfirmPasswordButton.tintColor = UIColor.white
                ConfirmPasswordButton.isEnabled = true
            } else {
                ConfirmPasswordButton.backgroundColor = UIColor(named: "ButtonNoClick")
                ConfirmPasswordButton.tintColor = UIColor.lightGray
                ConfirmPasswordButton.isEnabled = false
            }
        }
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if ((!(NewPasswordTextField.text ?? "").isEmpty) && (!(NewConfirmTextField.text ?? "").isEmpty)) {
            ConfirmPasswordButton.backgroundColor = UIColor(named: "primary")
            ConfirmPasswordButton.tintColor = UIColor.white
            ConfirmPasswordButton.isEnabled = true
        }else{
            ConfirmPasswordButton.backgroundColor = UIColor(named: "ButtonNoClick")
            ConfirmPasswordButton.tintColor = UIColor.lightGray
            ConfirmPasswordButton.isEnabled = false
        }
        switch textField {
        case NewPasswordTextField:
            showImagePassword.tintColor = UIColor(named: "primary")
            bottomLinePassword.backgroundColor = UIColor(named: "primary")?.cgColor
            NewPasswordTextField.layer.addSublayer(bottomLinePassword)
        case NewConfirmTextField:
            showImagePasswordConfirm.tintColor = UIColor(named: "primary")
            bottomLinePasswordConfirm.backgroundColor = UIColor(named: "primary")?.cgColor
            NewConfirmTextField.layer.addSublayer(bottomLinePasswordConfirm)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case NewPasswordTextField:
            if !(NewPasswordTextField.text ?? "").isEmpty {
                showImagePassword.tintColor = UIColor(named: "primary")
                bottomLinePassword.backgroundColor = UIColor(named: "primary")?.cgColor
                NewPasswordTextField.layer.addSublayer(bottomLinePassword)
            }else{
                showImagePassword.tintColor = UIColor(named: "ButtonNoClick")
                bottomLinePassword.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
                NewPasswordTextField.layer.addSublayer(bottomLinePassword)
            }
                
        case NewConfirmTextField:
            if !(NewConfirmTextField.text ?? "").isEmpty {
                showImagePasswordConfirm.tintColor = UIColor(named: "primary")
                bottomLinePasswordConfirm.backgroundColor = UIColor(named: "primary")?.cgColor
                NewConfirmTextField.layer.addSublayer(bottomLinePasswordConfirm)
            }else{
                showImagePasswordConfirm.tintColor = UIColor(named: "ButtonNoClick")
                bottomLinePasswordConfirm.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
                NewConfirmTextField.layer.addSublayer(bottomLinePasswordConfirm)
            }
        default:
            break
        }
    }
}

