//
//  StringExtensions.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 14/08/23.
//

import Foundation


extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var isPassword: Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: self)
    }
    
    var isUsername: Bool {
        let usernameRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let usernamePred = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return usernamePred.evaluate(with: self)
    }
    
    var isOtp: Bool {
        let otpRegEx = "^[A-Za-z0-9]$"
        let otpPred = NSPredicate(format: "SELF MATCHES %@", otpRegEx)
        return otpPred.evaluate(with: self)
    }
    
}
