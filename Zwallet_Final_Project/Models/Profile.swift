//
//  Profile.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 12/08/23.
//

import Foundation

struct Profile: Codable {
    let status: Int
    let message: String
    let data: DataClass
    
    struct DataClass: Codable {
        let firstname, lastname, email, phone: String
        let image: String
    }

}

// MARK: - DataClass
