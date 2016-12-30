//
//  ConfirmVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-25.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class ConfirmVC: UIViewController, DataServiceDelegate {
    
    @IBOutlet weak var codeTxtFld: MaterialTxtFld!
    var dataService = DataService.instance
    var admin = false
    var isCodeCorrect = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataService.delegate = self
    }
    
    func patientsLoaded() {
        
    }
    
    func planLoaded() {
        
    }
    
    func codesLoaded() {

        OperationQueue.main.addOperation {

            guard let codeTxt = self.codeTxtFld.text, self.codeTxtFld.text != "" else {
                        //show alert
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
                            self.performSegue(withIdentifier: "showRegisterVC", sender: self)
                        }
                    }
         
            if self.isCodeCorrect == false {
                print("Wrong code BITCH!")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backBtn(_ sender: Any) {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func codeSubmit(_ sender: UIButton) {
        dataService.getAllCodes()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRegisterVC" {
            if let destinVC = segue.destination as? RegisterVC {
                destinVC.isAdmin = admin
            }
        }
    }
    
}

