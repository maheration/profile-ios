//
//  LoginVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-28.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var emailTxtFld: MaterialTxtFld!
    @IBOutlet weak var passwordTxtFld: MaterialTxtFld!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func loginBtnPressed(_ sender: UIButton) {
        guard let emailTxt = emailTxtFld.text, emailTxtFld.text != "", let password = passwordTxtFld.text, passwordTxtFld.text != "" else {
            print("All fiields are required")
            return
        }
        
        AuthService.instance.login(email: emailTxt, password: password, completion: { Success in
            
            if Success {
                // login is good
                //check if admin or not
                if AuthService.instance.isAdmin! {
                    //admin
                    OperationQueue.main.addOperation {
                        print(AuthService.instance.isAdmin!)
                        self.performSegue(withIdentifier: "showAdminVC", sender: self)
                    }
                    
                } else {
                    //patient
                    OperationQueue.main.addOperation {
                        print(AuthService.instance.isAdmin!)
                        self.performSegue(withIdentifier: "showPatientVC", sender: self)
                    }
                }
            }
        
        })
        
        
    }

}
