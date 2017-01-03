//
//  AdminMedsDetailVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-03.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class AdminMedsDetailVC: UIViewController {
    //outlets
    @IBOutlet weak var medsTitleLbl: UILabel!
    @IBOutlet weak var medsDiscLbl: UILabel!
    //vars
    var transMeds : Medication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let med = transMeds {
            medsTitleLbl.text = med.name
            medsDiscLbl.text = med.disc
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    

}
