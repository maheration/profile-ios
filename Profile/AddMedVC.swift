//
//  AddMedVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-04.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class AddMedVC: UIViewController {
    
    //outlet
    @IBOutlet weak var medNameTxtFld: MaterialTxtFld!
    @IBOutlet weak var medDiscTxtFld: MaterialTextView!

    //vars
    var patientId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        guard let medName = medNameTxtFld.text, medNameTxtFld.text != "", let medDisc = medDiscTxtFld.text, medDiscTxtFld.text != "" else {
            //show alert
            print("All fields are required")
            return
        }
        if let id = patientId {
            DataService.instance.addNewMed(id, name: medName, disc: medDisc, completion: { (Success) in
                if Success {
                    //saved a new med
                    print("Successfully saved a new med")
                    self.dismissVC()
                } else {
                    //show alert
                    print("Failed to save a new med")
                }
            })
        }
    }


    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismissVC()
    }
    
    
    func dismissVC() {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
