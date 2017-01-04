//
//  EditMedVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-04.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class EditMedVC: UIViewController {

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
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {
        dismissVC()
    }

    @IBAction func updateBtnPressed(_ sender: UIButton) {
        guard let medName = nameMedTxtFld.text, nameMedTxtFld.text != "", let medDisc = discMedTxtFld.text, discMedTxtFld.text != "" else {
            //show alert 
            print("All fields are required")
            return
        }
        
        DataService.instance.updateMed(med.id, patientId: patientId!, name: medName, disc: medDisc) { (Success) in
            if Success {
                //perfect
                print("Meds was updated")
                self.dismissVC()
            } else {
                print("failed update")
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
