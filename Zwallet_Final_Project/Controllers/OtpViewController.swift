//
//  OtpViewController.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 13/08/23.
//

import UIKit

class OtpViewController: UIViewController {

    @IBOutlet weak var backgroundRounded: UIView!
    @IBOutlet weak var numberOne: UITextField!
    @IBOutlet weak var numberTwo: UITextField!
    @IBOutlet weak var numberThree: UITextField!
    @IBOutlet weak var numberFour: UITextField!
    @IBOutlet weak var numberFive: UITextField!
    @IBOutlet weak var numberSix: UITextField!
    @IBOutlet weak var ConfirmButton: CustomButton!
    
    var bottomNumberOne = CALayer()
    var bottomNumberTwo = CALayer()
    var bottomNumberThree = CALayer()
    var bottomNumberFour = CALayer()
    var bottomNumberFive = CALayer()
    var bottomNumberSix = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
    }
    
    func setup() {
        numberOne.delegate = self
        numberTwo.delegate = self
        numberThree.delegate = self
        numberFour.delegate = self
        numberFive.delegate = self
        numberSix.delegate = self
        
        backgroundRounded.dropShadow()
        
        //button
        
        ConfirmButton.backgroundColor = UIColor(named: "ButtonNoClick")
        ConfirmButton.tintColor = UIColor.lightGray
        
        
        
        
//        bottomNumberOne.frame = CGRectMake(
//            numberOne.frame.origin.x,
//            numberOne.frame.origin.y,
//            numberOne.frame.width,
//            numberOne.frame.height
//        )
//        
//        bottomNumberOne.backgroundColor = UIColor(named: "ButtonNoClick")?.cgColor
//        numberOne.layer.addSublayer(bottomNumberOne)

//        ConfirmButton.isEnabled = false
        
    }
    
    func displayMessageSignUp(userMessage: String, title: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func ConfirmButtonTapped(_ sender: Any) {
        displayMessageSignUp(userMessage: "Congratulation, Sign Up Success 🎉", title: "Sign Up")
    }
    
}

extension UIViewController {
    func showOtpViewPage(){
        if isViewLoaded {
            let storyboard = UIStoryboard(name: "Otp", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Otp")
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}


extension OtpViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case numberOne:
            numberOne.layer.borderWidth = 1
            numberOne.layer.borderColor = UIColor(named: "primary")?.cgColor
            numberOne.layer.cornerRadius = 10
        case numberTwo:
            numberTwo.layer.borderWidth = 1
            numberTwo.layer.borderColor = UIColor(named: "primary")?.cgColor
            numberTwo.layer.cornerRadius = 10
        case numberThree:
            numberThree.layer.borderWidth = 1
            numberThree.layer.borderColor = UIColor(named: "primary")?.cgColor
            numberThree.layer.cornerRadius = 10
        case numberFour:
            numberFour.layer.borderWidth = 1
            numberFour.layer.borderColor = UIColor(named: "primary")?.cgColor
            numberFour.layer.cornerRadius = 10
        case numberFive:
            numberFive.layer.borderWidth = 1
            numberFive.layer.borderColor = UIColor(named: "primary")?.cgColor
            numberFive.layer.cornerRadius = 10
        case numberSix:
            numberSix.layer.borderWidth = 1
            numberSix.layer.borderColor = UIColor(named: "primary")?.cgColor
            
        default:
            break
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        
        if text.count == 1 {
            switch textField {
            case numberOne:
                numberOne.text = text
                numberTwo.becomeFirstResponder()
            case numberTwo:
                numberTwo.text = text
                numberThree.becomeFirstResponder()
            case numberThree:
                numberThree.text = text
                numberFour.becomeFirstResponder()
            case numberFour:
                numberFour.text = text
                numberFive.becomeFirstResponder()
            case numberFive:
                numberFive.text = text
                numberSix.becomeFirstResponder()
            case numberSix:
                numberSix.text = text
                numberSix.resignFirstResponder()
            default:
                break
            }
        }
        
        if textField == numberOne {
            if text.isOtp && (numberTwo.text ?? "").isOtp && (numberThree.text ?? "").isOtp && (numberFour.text ?? "").isOtp && (numberFive.text ?? "").isOtp && (numberSix.text ?? "").isOtp {
                ConfirmButton.backgroundColor = UIColor(named: "primary")
                ConfirmButton.tintColor = UIColor.white
                ConfirmButton.isEnabled = true
            } else {
                ConfirmButton.backgroundColor = UIColor(named: "ButtonNoClick")
                ConfirmButton.tintColor = UIColor.lightGray
                ConfirmButton.isEnabled = false
            }
        } else if textField == numberTwo {
            if text.isOtp && (numberOne.text ?? "").isOtp && (numberThree.text ?? "").isOtp && (numberFour.text ?? "").isOtp && (numberFive.text ?? "").isOtp && (numberSix.text ?? "").isOtp {
                ConfirmButton.backgroundColor = UIColor(named: "primary")
                ConfirmButton.tintColor = UIColor.white
                ConfirmButton.isEnabled = true
            } else {
                ConfirmButton.backgroundColor = UIColor(named: "ButtonNoClick")
                ConfirmButton.tintColor = UIColor.lightGray
                ConfirmButton.isEnabled = false
            }
        } else if textField == numberThree {
            if text.isOtp && (numberOne.text ?? "").isOtp && (numberTwo.text ?? "").isOtp && (numberFour.text ?? "").isOtp && (numberFive.text ?? "").isOtp && (numberSix.text ?? "").isOtp {
                ConfirmButton.backgroundColor = UIColor(named: "primary")
                ConfirmButton.tintColor = UIColor.white
                ConfirmButton.isEnabled = true
            } else {
                ConfirmButton.backgroundColor = UIColor(named: "ButtonNoClick")
                ConfirmButton.tintColor = UIColor.lightGray
                ConfirmButton.isEnabled = false
            }
        } else if textField == numberFour {
            if text.isOtp && (numberOne.text ?? "").isOtp && (numberTwo.text ?? "").isOtp && (numberThree.text ?? "").isOtp && (numberFive.text ?? "").isOtp && (numberSix.text ?? "").isOtp {
                ConfirmButton.backgroundColor = UIColor(named: "primary")
                ConfirmButton.tintColor = UIColor.white
                ConfirmButton.isEnabled = true
            } else {
                ConfirmButton.backgroundColor = UIColor(named: "ButtonNoClick")
                ConfirmButton.tintColor = UIColor.lightGray
                ConfirmButton.isEnabled = false
            }
        } else if textField == numberFive {
            if text.isOtp && (numberOne.text ?? "").isOtp && (numberTwo.text ?? "").isOtp && (numberThree.text ?? "").isOtp && (numberFour.text ?? "").isOtp && (numberSix.text ?? "").isOtp {
                ConfirmButton.backgroundColor = UIColor(named: "primary")
                ConfirmButton.tintColor = UIColor.white
                ConfirmButton.isEnabled = true
            } else {
                ConfirmButton.backgroundColor = UIColor(named: "ButtonNoClick")
                ConfirmButton.tintColor = UIColor.lightGray
                ConfirmButton.isEnabled = false
            }
        } else if textField == numberSix {
            if text.isOtp && (numberOne.text ?? "").isOtp && (numberTwo.text ?? "").isOtp && (numberThree.text ?? "").isOtp && (numberFour.text ?? "").isOtp && (numberFive.text ?? "").isOtp {
                ConfirmButton.backgroundColor = UIColor(named: "primary")
                ConfirmButton.tintColor = UIColor.white
                ConfirmButton.isEnabled = true
            } else {
                ConfirmButton.backgroundColor = UIColor(named: "ButtonNoClick")
                ConfirmButton.tintColor = UIColor.lightGray
                ConfirmButton.isEnabled = false
            }
        }
        let maxLength = 1
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
        
        //        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if ((!(numberOne.text ?? "").isEmpty) && (!(numberTwo.text ?? "").isEmpty) && (!(numberThree.text ?? "").isEmpty) && (!(numberFour.text ?? "").isEmpty) && (!(numberFive.text ?? "").isEmpty) && (!(numberSix.text ?? "").isEmpty) )  {
            ConfirmButton.backgroundColor = UIColor(named: "primary")
            ConfirmButton.tintColor = UIColor.white
            ConfirmButton.isEnabled = true
        }else{
            ConfirmButton.backgroundColor = UIColor(named: "ButtonNoClick")
            ConfirmButton.tintColor = UIColor.lightGray
            ConfirmButton.isEnabled = false
        }
        
        switch textField {
        case numberOne:
            if !(numberOne.text ?? "").isEmpty{
                numberOne.layer.borderWidth = 1
                numberOne.layer.borderColor = UIColor(named: "primary")?.cgColor
                numberOne.layer.cornerRadius = 10
            } else {
                numberOne.layer.borderWidth = 1
                numberOne.layer.borderColor = UIColor(named: "ButtonNoClick")?.cgColor
                numberOne.layer.cornerRadius = 10
            }
        case numberTwo:
            if !(numberTwo.text ?? "").isEmpty{
                numberTwo.layer.borderWidth = 1
                numberTwo.layer.borderColor = UIColor(named: "primary")?.cgColor
                numberTwo.layer.cornerRadius = 10
            } else {
                numberTwo.layer.borderWidth = 1
                numberTwo.layer.borderColor = UIColor(named: "ButtonNoClick")?.cgColor
                numberTwo.layer.cornerRadius = 10
            }
            
        case numberThree:
            if !(numberThree.text ?? "").isEmpty{
                numberThree.layer.borderWidth = 1
                numberThree.layer.borderColor = UIColor(named: "primary")?.cgColor
                numberThree.layer.cornerRadius = 10
            } else {
                numberThree.layer.borderWidth = 1
                numberThree.layer.borderColor = UIColor(named: "ButtonNoClick")?.cgColor
                numberThree.layer.cornerRadius = 10
            }
            
        case numberFour:
            if !(numberFour.text ?? "").isEmpty{
                numberFour.layer.borderWidth = 1
                numberFour.layer.borderColor = UIColor(named: "primary")?.cgColor
                numberFour.layer.cornerRadius = 10
            } else {
                numberFour.layer.borderWidth = 1
                numberFour.layer.borderColor = UIColor(named: "ButtonNoClick")?.cgColor
                numberFour.layer.cornerRadius = 10
            }
            
        case numberFive:
            if !(numberFive.text ?? "").isEmpty{
                numberFive.layer.borderWidth = 1
                numberFive.layer.borderColor = UIColor(named: "primary")?.cgColor
                numberFive.layer.cornerRadius = 10
            } else {
                numberFive.layer.borderWidth = 1
                numberFive.layer.borderColor = UIColor(named: "ButtonNoClick")?.cgColor
                numberFive.layer.cornerRadius = 10
            }
            
        case numberSix:
            if !(numberSix.text ?? "").isEmpty{
                numberSix.layer.borderWidth = 1
                numberSix.layer.borderColor = UIColor(named: "primary")?.cgColor
                numberSix.layer.cornerRadius = 10
            } else {
                numberSix.layer.borderWidth = 1
                numberSix.layer.borderColor = UIColor(named: "ButtonNoClick")?.cgColor
                numberSix.layer.cornerRadius = 10
            }
        
        default:
            break
        }
    }
}




