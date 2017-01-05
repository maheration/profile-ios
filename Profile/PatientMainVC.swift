//
//  PatientMainVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-28.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class PatientMainVC: UIViewController, DataServiceDelegate {
    
    //outlets
    @IBOutlet weak var dxLbl: UILabel!
    @IBOutlet weak var dxBg: UIView!
    @IBOutlet weak var planBg: UIView!
    @IBOutlet weak var planLbl: UILabel!
    @IBOutlet weak var labsBg: UIView!
    @IBOutlet weak var labsLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    //vars
    var dataService = DataService.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        dxLbl.isHidden = true
        dxBg.isHidden = true
        planBg.isHidden = true
        planLbl.isHidden = true
        labsBg.isHidden = true
        labsLbl.isHidden = true
        infoLbl.isHidden = false
        
        
        dataService.delegate = self
        if let userId = AuthService.instance.id {
            dataService.getPatientPlan(userId)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func planLoaded() {
        OperationQueue.main.addOperation {
            if self.dataService.plans.count > 0 {
                self.dxLbl.isHidden = false
                self.dxBg.isHidden = false
                self.planBg.isHidden = false
                self.planLbl.isHidden = false
                self.labsBg.isHidden = false
                self.labsLbl.isHidden = false
                self.infoLbl.isHidden = true
                self.dxLbl.text = self.dataService.plans[0].dx
                self.labsLbl.text = self.dataService.plans[0].labs
                self.planLbl.text = self.dataService.plans[0].plan
            } else {
                self.dxLbl.isHidden = true
                self.dxBg.isHidden = true
                self.planBg.isHidden = true
                self.planLbl.isHidden = true
                self.labsBg.isHidden = true
                self.labsLbl.isHidden = true
                self.infoLbl.isHidden = false
            }
        }
        
    }
    
    func patientsLoaded() {
        //nil
    }
    
    func codesLoaded() {
        //nil
    }
    
    func medsLoaded() {
        //nil
    }

}
