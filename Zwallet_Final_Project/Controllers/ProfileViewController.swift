//
//  ProfileViewController.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit


class ProfileViewController: UIViewController {

    @IBOutlet weak var ImageProfile: UIImageView!
    @IBOutlet weak var EditButton: UIButton!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    
    @IBOutlet weak var PersonalInformationButton: CustomButton!
    @IBOutlet weak var ChangePasswordButton: CustomButton!
    @IBOutlet weak var ChangePinButton: CustomButton!
    @IBOutlet weak var NotificationToggleButton: CustomButton!
    @IBOutlet weak var LogoutButton: CustomButton!
    
    var status: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupApi()
        setup()
    }
    
    func setupApi(){
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
            
            DispatchQueue.main.async { [self] in
                if(responseProfile.statusCode == 200){
                    do {
                        let responseProfileModel = try JSONDecoder().decode(Profile.self, from: data)
                        
                        DispatchQueue.global().async {
                            let imageData = try? Data(contentsOf: URL(string: "\(Constants.getPhoto)\(responseProfileModel.data.image)")!)

                            if let imageData = imageData {
                                DispatchQueue.main.async { [weak self] in
                                    self?.ImageProfile.image = UIImage(data: imageData)
                                }
                            }
                        }
                        
                        if responseProfileModel.data.phone.isEmpty{
                            PhoneNumberLabel?.text = "089627934528"
                        } else {
                            PhoneNumberLabel?.text = responseProfileModel.data.phone
                        }
                            
                        NameLabel?.text = responseProfileModel.data.firstname
                        NameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
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
    
    func setup(){
        ImageProfile.layer.cornerRadius = 10
        ImageProfile.clipsToBounds = true
    }
    
    func displayMessageLogout(userMessage: String, title: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")

                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
                
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

    @IBAction func logoutTapped(_ sender: Any) {
        let token: String = UserDefaults.standard.string(forKey: "token")!
        let apiUrl = URL(string: "\(Constants.logoutUrl)/\(token)")!
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "DELETE"
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
                print("Response Logout User: \(responseString)")
            }
            
            DispatchQueue.main.async {
                if(responseProfile.statusCode == 200){

                } else if(responseProfile.statusCode == 404){
                    
                }
            }
        }
        task.resume()
        
        UserDefaults.standard.setValue(nil, forKey: "token")
        displayMessageLogout(userMessage: "Are you sure want to logout? 😭", title: "Logout")
    }
    
    @IBAction func notificationTapped(_ sender: Any) {
        let toggleOff = UIImage(named: "off")
        let toggleOn = UIImage(named: "on")
        status += 1
        if(status == 2){
            status = 0
        }
        
        if(status % 2 == 0){
            self.PersonalInformationButton.backgroundColor = UIColor(named: "ButtonNoClick")
            self.ChangePasswordButton.backgroundColor = UIColor(named: "ButtonNoClick")
            self.ChangePinButton.backgroundColor = UIColor(named: "ButtonNoClick")
            self.NotificationToggleButton.setImage(toggleOff, for: .normal)
            self.NotificationToggleButton.backgroundColor = UIColor(named: "ButtonNoClick")
            self.LogoutButton.backgroundColor = UIColor(named: "ButtonNoClick")
            self.LogoutButton.tintColor = UIColor.black
            self.LogoutButton.contentHorizontalAlignment = .leading
            
        } else if(status % 2 == 1){
            self.PersonalInformationButton.backgroundColor = UIColor.white
            self.PersonalInformationButton.dropShadow()
            self.ChangePasswordButton.backgroundColor = UIColor.white
            self.ChangePasswordButton.dropShadow()
            self.ChangePinButton.backgroundColor = UIColor.white
            self.ChangePinButton.dropShadow()
            self.NotificationToggleButton.backgroundColor = UIColor.white
            self.NotificationToggleButton.setImage(toggleOn, for: .normal)
            self.NotificationToggleButton.dropShadow()
            self.LogoutButton.backgroundColor = UIColor.white
            self.LogoutButton.tintColor = UIColor.red
            self.LogoutButton.contentHorizontalAlignment = .center
            self.LogoutButton.contentVerticalAlignment = .center
            self.LogoutButton.dropShadow()
        }
    }
}



