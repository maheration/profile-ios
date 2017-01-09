//
//  EditPlanVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-01.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class EditPlanVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dxTxtFld: MaterialTxtFld!
    @IBOutlet weak var labsTxtFld: MaterialTxtFld!
    @IBOutlet weak var planTxtFld: MaterialTextView!
    @IBOutlet weak var linkBtn: UIButton!
    
    var transPatient : Patient?
    var dataService = DataService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dxTxtFld.text = dataService.plans[0].dx
        labsTxtFld.text = dataService.plans[0].labs
        planTxtFld.text = dataService.plans[0].plan
        NotificationCenter.default.addObserver(self, selector: #selector(EditPlanVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditPlanVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditPlanVC.dismiss(notification:)))
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
    
    @IBAction func updateBtnPressed(_ sender: UIButton) {
        guard let dx = dxTxtFld.text, dxTxtFld.text != "", let labs = labsTxtFld.text, labsTxtFld.text != "", let plan = planTxtFld.text, planTxtFld.text != "" else {
            // show alert
            print("All fields are required")
            showAlert(with: "ERROR", message: "All fields are required. Please try again :)")
            return
        }
        guard let patient = transPatient else { return }
        dataService.updatePlan(patient.id, dx: dx, plan: plan, labs: labs) { Success in
            if Success {
                // updated
                self.dismissVC()
            } else {
                // failed
                self.showAlert(with: "ERROR", message: "An error occured! Plan was not updated. Please try again")
                print("Failed updating")
            }
        }
    }

    @IBAction func linkBtnPressed(_ sender: UIButton) {
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
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
