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
                do {
                    let responseProfileModel = try JSONDecoder().decode(Profile.self, from: data)
                    
                    DispatchQueue.global().async {
                        let imageData = try? Data(contentsOf: URL(string: "\(Constants.getPhoto)\(responseProfileModel.data.image)")!)

                        if let imageData = imageData {
                            DispatchQueue.main.async {
//                                self?.ImageProfile.image = UIImage(data: imageData)
                            }
                        }
                    }
                    
//                    if responseProfileModel.data.phone.isEmpty{
//                        PhoneNumberLabel?.text = "089627934528"
//                    } else {
//                        PhoneNumberLabel?.text = responseProfileModel.data.phone
//                    }
                        
//                    NameLabel?.text = responseProfileModel.data.firstname
//                    NameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
                    UserDefaults.standard.set(data, forKey: "profileData")
                    
                } catch let jsonErr {
                        print(jsonErr)
                }
                
            } else if(responseProfile.statusCode == 404){
                
            }
        }
    }
    task.resume()
    
}
