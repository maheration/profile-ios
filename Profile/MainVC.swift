//
//  MainVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-10.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit
import UserNotifications

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !connectedToNetwork() {
            showAlert(with: "No Internet Connection Found", message: "Please make sure that you are connected to the internet :)")
        }
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.soundSetting {
            case .enabled:
                print("enabled")
            case .disabled:
                self.showAlert(with: "Notification is Not Enabled", message: "Please enable notification in the settings to get notified when your plan or medications get updated :)")
                print("Please enable notification in the settings to get notified when the plan or you medications get updated.")
            case .notSupported:
                print("Big error")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showConfirmVC", sender: nil)
    }

    @IBAction func loginBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showLoginVC", sender: self)
    }
    
    //Alert func
    func showAlert(with title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
