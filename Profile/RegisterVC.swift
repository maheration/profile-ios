//
//  RegisterVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-27.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    //variables
    var isAdmin = false
    
    //Outlets
    @IBOutlet weak var firstNameTxtFld: MaterialTxtFld!
    @IBOutlet weak var lastNameTxtFld: MaterialTxtFld!
    @IBOutlet weak var emailTxtFld: MaterialTxtFld!
    @IBOutlet weak var passwordTxtFld: MaterialTxtFld!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC .keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.dismiss(notification:)))
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
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        guard let emailTxt = emailTxtFld.text, emailTxtFld.text != "", let firstName = firstNameTxtFld.text, firstNameTxtFld.text != "", let lastName = lastNameTxtFld.text, lastNameTxtFld.text != "", let password = passwordTxtFld.text, passwordTxtFld.text != "" else {
            print("Show arror msg")
            showAlert(with: "ERROR", message: "All fields are required!")
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
                        self.showAlert(with: "ERROR", message: "Please contact us for assistance!")
                        print("Error")
                    }
                })
            } else {
                self.showAlert(with: "ERROR", message: "Please contact us for assistance!")
                print("error")
            }
            
        })
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        OperationQueue.main.addOperation {
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    //Alert func
    func showAlert(with title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
