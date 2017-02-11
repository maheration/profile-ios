//
//  AddMedVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-04.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class AddMedVC: UIViewController, UITextFieldDelegate {
    
    //outlet
    @IBOutlet weak var medNameTxtFld: MaterialTxtFld!
    @IBOutlet weak var medDiscTxtFld: MaterialTextView!
    @IBOutlet weak var saveBtn : MaterialButton!

    //vars
    var patientId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(AddMedVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddMedVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddMedVC.dismiss(notification:)))
        view.addGestureRecognizer(tap)

    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 120
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 120
        }
    }
    
    func dismiss(notification: NSNotification) {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        saveBtn.isEnabled = false
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(AddMedVC.enableBtn), userInfo: nil, repeats: false)
        guard let medName = medNameTxtFld.text, medNameTxtFld.text != "", let medDisc = medDiscTxtFld.text, medDiscTxtFld.text != "" else {
            //show alert
            print("All fields are required")
            showAlert(with: "All Fields Are Required", message: "Please fill all fields and try again :)")
            return
        }
        if let id = patientId {
            DataService.instance.addNewMed(id, name: medName, disc: medDisc, completion: { (Success) in
                if Success {
                    //saved a new med
                    OperationQueue.main.addOperation {
                        DataService.instance.sendNotif(id)
                    }
                    print("Successfully saved a new med")
                    self.dismissVC()
                } else {
                    //show alert
                    self.showAlert(with: "ERROR", message: "Medication was not saved. Please try again")
                    print("Failed to save a new med")
                }
            })
        }
    }
    
    func enableBtn() {
        saveBtn.isEnabled = true
    }


    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismissVC()
    }
    
    
    func dismissVC() {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
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
