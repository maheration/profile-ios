//
//  EditMedVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-04.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class EditMedVC: UIViewController, UITextFieldDelegate {

    //outlets
    @IBOutlet weak var discMedTxtFld: MaterialTextView!
    @IBOutlet weak var nameMedTxtFld: MaterialTxtFld!
    @IBOutlet weak var updateBtn: MaterialButton!
    
    //vars
    var selectedRow : Int?
    var patientId : String?
    var med = Medication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let row = selectedRow {
            med = DataService.instance.meds[row]
            nameMedTxtFld.text = med.name
            discMedTxtFld.text = med.disc
            NotificationCenter.default.addObserver(self, selector: #selector(EditMedVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(EditMedVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(EditMedVC.dismiss(notification:)))
            view.addGestureRecognizer(tap)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

    @IBAction func backBtnPressed(_ sender: Any) {
        dismissVC()
    }

    @IBAction func updateBtnPressed(_ sender: UIButton) {
        updateBtn.isEnabled = false
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(EditMedVC.enableBtn), userInfo: nil, repeats: false)
        guard let medName = nameMedTxtFld.text, nameMedTxtFld.text != "", let medDisc = discMedTxtFld.text, discMedTxtFld.text != "" else {
            //show alert 
            print("All fields are required")
            showAlert(with: "Error", message: "Please fill all fields and try again :)")
            return
        }
        guard let ptId = patientId else { return }
        DataService.instance.updateMed(med.id, patientId: ptId, name: medName, disc: medDisc) { (Success) in
            if Success {
                //perfect
                print("Meds was updated")
                OperationQueue.main.addOperation {
                    DataService.instance.sendNotif(ptId)
                }
                self.dismissVC()
            } else {
                print("failed update")
                self.showAlert(with: "ERROR", message: "Medication was not updated! Please try again")
                //show alert
            }
        }
    }
    
    func enableBtn() {
        updateBtn.isEnabled = true
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
