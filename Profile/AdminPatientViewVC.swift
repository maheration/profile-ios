//
//  AdminPatientViewVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-30.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class AdminPatientViewVC: UIViewController {
    
    @IBOutlet weak var medsBtn: MaterialViewRoundedCorner!
    @IBOutlet weak var planBtn: MaterialViewRoundedCorner!
    @IBOutlet weak var patientNameLbl: UILabel!
    var transferredPatient: Patient?

    override func viewDidLoad() {
        super.viewDidLoad()
        let planTapped = UITapGestureRecognizer(target: self, action: #selector(self.planBtntapped(_:)))
        planBtn.addGestureRecognizer(planTapped)
        
        let medsTapped = UITapGestureRecognizer(target: self, action: #selector(self.medsBtnTapped(_:)))
        medsBtn.addGestureRecognizer(medsTapped)
        
        if let patientTransferred = transferredPatient {
            patientNameLbl.text = patientTransferred.fullName
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
       let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func planBtntapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "showAdminPlanVC", sender: self)
    }
    
    func medsBtnTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "showAdminMedsVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminPlanVC" {
            let destinVC = segue.destination as! AdminPlanVC
            if let transPatient = transferredPatient {
                destinVC.patient = transPatient
            }
        }
        
        if segue.identifier == "showAdminMedsVC" {
            let destinVC = segue.destination as! AdminMedsVC
            if let pt = transferredPatient {
                destinVC.patientId = pt.id
            }
        }
    }
}
