//
//  AdminPlanVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-30.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class AdminPlanVC: UIViewController, DataServiceDelegate {
    
    //outlets
    @IBOutlet weak var dxBG: UIView!
    @IBOutlet weak var dxLbl: UILabel!
    @IBOutlet weak var labsBg: UIView!
    @IBOutlet weak var labsLbl: UILabel!
    @IBOutlet weak var planBg: UIView!
    @IBOutlet weak var planLbl: UILabel!
    @IBOutlet weak var addPlanBtn: UIButton!
    @IBOutlet weak var loadingBG: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var lblTxt : UILabel!
    
    let dataService = DataService.instance
    var patient : Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.delegate = self
        dxBG.isHidden = true
        dxLbl.isHidden = true
        labsBg.isHidden = true
        labsLbl.isHidden = true
        planBg.isHidden = true
        planLbl.isHidden = true
        activityIndicator.startAnimating()
        loadingBG.isHidden = false
        
        if let transPatient = patient {
            dataService.getPatientPlan(transPatient.id)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func planLoaded() {
        
        OperationQueue.main.addOperation {
            if self.dataService.plans.count > 0 {
                self.editBtn.isHidden = false
                self.lblTxt.isHidden = true
                self.activityIndicator.stopAnimating()
                self.loadingBG.isHidden = true
                self.dxBG.isHidden = false
                self.dxLbl.isHidden = false
                self.labsBg.isHidden = false
                self.labsLbl.isHidden = false
                self.planBg.isHidden = false
                self.planLbl.isHidden = false
                self.addPlanBtn.isHidden = true
                self.dxLbl.text = self.dataService.plans[0].dx
                self.labsLbl.text = self.dataService.plans[0].labs
                self.planLbl.text = self.dataService.plans[0].plan
                
            } else {
                self.editBtn.isHidden = true
                self.lblTxt.isHidden = false
                self.loadingBG.isHidden = true
                self.activityIndicator.stopAnimating()
                self.dxBG.isHidden = true
                self.dxLbl.isHidden = true
                self.labsBg.isHidden = true
                self.labsLbl.isHidden = true
                self.planBg.isHidden = true
                self.planLbl.isHidden = true
                self.addPlanBtn.isHidden = false
            }
        }
    }
    
    func patientsLoaded() {
        //nothing to do
    }
    
    func codesLoaded() {
        //nothing to do
    }

    @IBAction func addBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "showAddPlanVC", sender: self)
    }
    @IBAction func editBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "showEditPlanVC", sender: self)
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddPlanVC" {
            let destinVC = segue.destination as! AddPlanVC
            if let transPatient = patient {
                destinVC.patientId = transPatient.id
            }
        }
        
        if segue.identifier == "showEditPlanVC" {
            let destinVC = segue.destination as! EditPlanVC
            if let transPatient = patient {
                destinVC.transPatient = transPatient
            }
        }
    }
    
    func medsLoaded() {
        //nothing
    }
}
