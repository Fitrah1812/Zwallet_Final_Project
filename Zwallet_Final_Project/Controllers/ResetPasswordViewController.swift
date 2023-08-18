//
//  ResetPasswordViewController.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var BackgroundRounded: CustomViewCornerRounded!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var ResetPasswordButton: CustomButton!
    
    var showImageEmail: UIImageView!
    var bottomLineEmail = CALayer()
    
    var emailReset: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        EmailTextField.delegate = self
        
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
        
        bottomLineEmail.frame = CGRectMake(
            0,
            EmailTextField.frame.height - 1,
            EmailTextField.frame.width,
            1.0
        )
        
    
        bottomLineEmail.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
        EmailTextField.layer.addSublayer(bottomLineEmail)
        
//        ResetPasswordButton.addTarget(self, action: #selector(handleClickButtonTapped), for: .touchUpInside)
        ResetPasswordButton.backgroundColor = (UIColor(named: "ButtonNoClick"))
        ResetPasswordButton.tintColor = UIColor.lightGray
//        ResetPasswordButton.isEnabled = false
        
        BackgroundRounded.dropShadow()
    }
    
    @objc private func handleClickButtonTapped() {

       let alertController = UIAlertController(title: "Reset Password", message: "Are you sure that you want to reset password?", preferredStyle: .alert)

       // adding actions to alert
       alertController.addAction(UIAlertAction(title: "Yes", style: .default))
       alertController.addAction(UIAlertAction(title: "No", style: .default))

       // present the alert on the screen
       self.present(alertController, animated: true)
    }
    
    @IBAction func PassNewPage(_ sender: Any) {
        displayMessageResetPassword(userMessage: "Are you sure want to reset password ? 😃", title: "Reset Password")
    }
    
    func displayMessageResetPassword(userMessage: String, title: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                let storyboard = UIStoryboard(name: "ResetPassNew", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ResetPassNew") as? ResetPassNewViewController
                viewController?.emailTransfered = (self.EmailTextField.text)!
                self.navigationController?.pushViewController(viewController!, animated: true)
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
}

extension UIViewController {
    func showResetPasswordController(){
        if isViewLoaded {
            let storyboard = UIStoryboard(name: "ResetPassword", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ResetPassword")
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}



extension ResetPasswordViewController: UITextFieldDelegate{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        if textField == EmailTextField {
            if text.isEmail {
                ResetPasswordButton.backgroundColor = UIColor(named: "primary")
                ResetPasswordButton.tintColor = UIColor.white
                ResetPasswordButton.isEnabled = true
            } else {
                ResetPasswordButton.backgroundColor = UIColor(named: "ButtonNoClick")
                ResetPasswordButton.tintColor = UIColor.lightGray
                ResetPasswordButton.isEnabled = false
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if ((!(EmailTextField.text ?? "").isEmpty)) {
            ResetPasswordButton.backgroundColor = UIColor(named: "primary")
            ResetPasswordButton.tintColor = UIColor.white
            ResetPasswordButton.isEnabled = true
        }else{
            ResetPasswordButton.backgroundColor = UIColor(named: "ButtonNoClick")
            ResetPasswordButton.tintColor = UIColor.lightGray
            ResetPasswordButton.isEnabled = false
        }
        switch textField {
        case EmailTextField:
            showImageEmail.tintColor = UIColor(named: "primary")
            bottomLineEmail.backgroundColor = UIColor(named: "primary")?.cgColor
            EmailTextField.layer.addSublayer(bottomLineEmail)
        default:
            break
        }
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
        default:
            break
        }
    }
}
