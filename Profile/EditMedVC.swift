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

    @IBAction func backBtnPressed(_ sender: Any) {
        dismissVC()
    }

    @IBAction func updateBtnPressed(_ sender: UIButton) {
        guard let medName = nameMedTxtFld.text, nameMedTxtFld.text != "", let medDisc = discMedTxtFld.text, discMedTxtFld.text != "" else {
            //show alert 
            print("All fields are required")
            showAlert(with: "Error", message: "Please fill all fields and try again :)")
            return
        }
        
        DataService.instance.updateMed(med.id, patientId: patientId!, name: medName, disc: medDisc) { (Success) in
            if Success {
                //perfect
                print("Meds was updated")
                self.dismissVC()
            } else {
                print("failed update")
                self.showAlert(with: "ERROR", message: "Medication was not updated! Please try again")
                //show alert
            }
        }
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
