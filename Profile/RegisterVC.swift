//
//  RegisterVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-27.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    //variables
    var isAdmin = false
    
    //Outlets
    @IBOutlet weak var firstNameTxtFld: MaterialTxtFld!
    @IBOutlet weak var lastNameTxtFld: MaterialTxtFld!
    @IBOutlet weak var emailTxtFld: MaterialTxtFld!
    @IBOutlet weak var passwordTxtFld: MaterialTxtFld!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        guard let emailTxt = emailTxtFld.text, emailTxtFld.text != "", let firstName = firstNameTxtFld.text, firstNameTxtFld.text != "", let lastName = lastNameTxtFld.text, lastNameTxtFld.text != "", let password = passwordTxtFld.text, passwordTxtFld.text != "" else {
            print("Show arror msg")
            return
        }
        
        AuthService.instance.registerUser(email: emailTxt, password: password, firstName: firstName, lastName: lastName, isAdmin: isAdmin, completion: { Success in
            if Success {
                AuthService.instance.login(email: emailTxt, password: password, completion: { (Success) in
                    if Success {
                        // check if admin or not
                        if self.isAdmin {
                            //segue to admin side
                            OperationQueue.main.addOperation {
                                self.performSegue(withIdentifier: "showAdminMainVC", sender: self)
                            }
                        } else {
                            //segue to patient side
                            OperationQueue.main.addOperation {
                                self.performSegue(withIdentifier: "showPatientMainVC", sender: self)
                            }
                        }
                    } else {
                        print("Error")
                    }
                })
            } else {
                print("error")
            }
            
        })
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        OperationQueue.main.addOperation {
            self.navigationController?.popViewController(animated: true)
        }
    }

}
