//
//  MainViewModel.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 18/08/23.
//

import Foundation

func fetchData() {
    
    let token: String = UserDefaults.standard.string(forKey: "token")!
    let apiUrl = URL(string: Constants.getProfile)!
    
    var request = URLRequest(url: apiUrl)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        let responseProfile = (response as? HTTPURLResponse)!
        if let error = error {
            print("Error: \(error)")
            return
        }
        guard let data = data else {
            print("No data received.")
            return
        }
        
        
        if let responseString = String(data: data, encoding: .utf8){
            print("Response get profile: \(responseString)")
        }
        
        DispatchQueue.main.async {
            if(responseProfile.statusCode == 200){
        
                
            } else if(responseProfile.statusCode == 404){
                
            }
        }
    }
    task.resume()
    
}
