//
//  PatientMedDetailVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-05.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class PatientMedDetailVC: UIViewController {

    //outlets
    @IBOutlet weak var updateLbl: UILabel!
    @IBOutlet weak var medDiscLbl: UILabel!
    @IBOutlet weak var medName: UILabel!
    
    //vars
    var selectedRow : Int?
    var med = Medication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let row = selectedRow {
            med = DataService.instance.meds[row]
            updateLbl.text = "Last updated on \(med.updatedDate)"
            medDiscLbl.text = med.disc
            medName.text = med.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

}
