//
//  HomeViewController.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        
    }
    
    
}


extension UIViewController {
    func showHomeController(){
        if isViewLoaded {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Home")
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
