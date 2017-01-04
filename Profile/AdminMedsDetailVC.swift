//
//  AdminMedsDetailVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-03.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class AdminMedsDetailVC: UIViewController, DataServiceDelegate {
    //outlets
    @IBOutlet weak var medsTitleLbl: UILabel!
    @IBOutlet weak var medsDiscLbl: UILabel!
    //vars
    var transMeds : Medication?
    var selectedRow : Int?
    var patientId : String?
    var dataService = DataService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.delegate = self
        if let med = transMeds {
            medsTitleLbl.text = med.name
            medsDiscLbl.text = med.disc
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showEditMedVC", sender: self)
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditMedVC" {
            if let row = selectedRow {
                let destinVC = segue.destination as! EditMedVC
                destinVC.selectedRow =  row
                destinVC.patientId = self.patientId
            }
        }
    }
    
    func patientsLoaded() {
        //nothing
    }
    
    func codesLoaded() {
        //nothing
    }
    
    func medsLoaded() {
        print("we are here")
        OperationQueue.main.addOperation {
            if let row = self.selectedRow {
                self.medsTitleLbl.text = self.dataService.meds[row].name
                self.medsDiscLbl.text = self.dataService.meds[row].disc
            }
        }
        
    }
    
    
    func planLoaded() {
        //nothing
    }
    

}
