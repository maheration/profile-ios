//
//  AddPlanVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-30.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class AddPlanVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var dxTxtFld: MaterialTxtFld!
    @IBOutlet weak var labsFreqTxtFld: MaterialTxtFld!
    @IBOutlet weak var planTxtFld: UITextView!

    //vars
    var patientId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
         self.dismissVC()
    }

    @IBAction func saveBtnPressed(_ sender: UIButton) {
        guard let dx = dxTxtFld.text, dxTxtFld.text != "", let labs = labsFreqTxtFld.text, labsFreqTxtFld.text != "", let plan = planTxtFld.text, planTxtFld.text != "" else {
            // show an alert here
            print("ALL Fields are mandatory")
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
            }
        }
    }
    
    func dismissVC() {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

}
