//
//  LoginVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-28.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTxtFld: MaterialTxtFld!
    @IBOutlet weak var passwordTxtFld: MaterialTxtFld!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC .keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismiss(notification:)))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 100
        }
    }
    
    func dismiss(notification: NSNotification) {
        view.endEditing(true)
    }
    

    @IBAction func backBtnPressed(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func loginBtnPressed(_ sender: UIButton) {
        guard let emailTxt = emailTxtFld.text, emailTxtFld.text != "", let password = passwordTxtFld.text, passwordTxtFld.text != "" else {
            print("All fiields are required")
            showAlert(with: "All fileds are required", message: "Please make sure to fill all fields")
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
            } else {
                OperationQueue.main.addOperation {
                    self.showAlert(with: "Error", message: "The email or password is wrong. Please try again :)")
                }
                
            }
        })
    }

    //Alert func
    func showAlert(with title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
