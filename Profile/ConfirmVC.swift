//
//  ConfirmVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-25.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class ConfirmVC: UIViewController, DataServiceDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var codeTxtFld: MaterialTxtFld!
    var dataService = DataService.instance
    var admin = false
    var isCodeCorrect = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if !connectedToNetwork() {
            showAlert(with: "No Internet Connection Found", message: "Please make sure that you are connected to the internet :)")
        }
        dataService.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(ConfirmVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ConfirmVC .keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConfirmVC.dismiss(notification:)))
        view.addGestureRecognizer(tap)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        admin = false
        isCodeCorrect = false
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 100
        }
    }
    
    func dismiss(notification: NSNotification) {
        view.endEditing(true)
    }
    
    func patientsLoaded() {
        
    }
    
    func planLoaded() {
        
    }
    
    func codesLoaded() {

        OperationQueue.main.addOperation {

            guard let codeTxt = self.codeTxtFld.text, self.codeTxtFld.text != "" else {
                        //show alert
                        self.showAlert(with: "ERROR", message: "All fileds are required")
                        return
                    }
                    for code in self.dataService.codes {
                        if codeTxt == code.code {
                            self.isCodeCorrect = true
                            if code.role == "admin" {
                                self.admin = true
                            } else {
                                self.admin = false
                            }
                            //delete this code based on id
                            self.dataService.deleteCode(code.id)
                            self.performSegue(withIdentifier: "showRegisterVC", sender: self)
                        }
                    }
         
            if self.isCodeCorrect == false {
                //show alert
                self.showAlert(with: "Wrong Code", message: "You entered a wrong code. Please double check your code or contact your coordinator")
                print("Wrong code BITCH!")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func backBtn(_ sender: Any) {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func codeSubmit(_ sender: UIButton) {
        
        dataService.getAllCodes()
        print(dataService.codes.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRegisterVC" {
            if let destinVC = segue.destination as? RegisterVC {
                destinVC.isAdmin = admin
            }
        }
    }
    
    func medsLoaded() {
     //nothing
    }

    //Alert func
    func showAlert(with title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

