//
//  Constants.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 12/08/23.
//

import Foundation

struct Constants {
    static let scheme = "http"
    static let baseURL = "54.158.117.176"
    static let port  = "8000"
    static let getPhoto = "\(scheme)://\(baseURL):\(port)"
    static let loginUrl = "\(scheme)://\(baseURL):\(port)/auth/login"
    static let signUpUrl = "\(scheme)://\(baseURL):\(port)/auth/signup"
    static let resetPass = "\(scheme)://\(baseURL):\(port)/auth/reset"
    static let logoutUrl = "\(scheme)://\(baseURL):\(port)/auth/logout"
    static let getProfile = "\(scheme)://\(baseURL):\(port)/user/myProfile"
}
