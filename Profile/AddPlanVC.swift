//
//  AddPlanVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-30.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class AddPlanVC: UIViewController, UITextFieldDelegate {
    
    //Outlets
    @IBOutlet weak var dxTxtFld: MaterialTxtFld!
    @IBOutlet weak var labsFreqTxtFld: MaterialTxtFld!
    @IBOutlet weak var planTxtFld: UITextView!

    //vars
    var patientId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(AddPlanVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddPlanVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddPlanVC.dismiss(notification:)))
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
         self.dismissVC()
    }

    @IBAction func saveBtnPressed(_ sender: UIButton) {
        guard let dx = dxTxtFld.text, dxTxtFld.text != "", let labs = labsFreqTxtFld.text, labsFreqTxtFld.text != "", let plan = planTxtFld.text, planTxtFld.text != "" else {
            // show an alert here
            print("ALL Fields are mandatory")
            showAlert(with: "ALL Fields are mandatory", message: "Please fill all fields")
            return
        }
        guard let id = patientId else { return }
        DataService.instance.postNewPlan(id, dx: dx, plan: plan, labs: labs) { Success in
            if Success {
                //Success
                print("Saved a new plan")
                self.dismissVC()
                
            } else {
                print("Was not able to save a new plan")
                //show alert
                self.showAlert(with: "Plan was not saved", message: "An error occured! Please try again")
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
