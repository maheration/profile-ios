//
//  PatientMedsVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2017-01-05.
//  Copyright © 2017 Maher Aldemerdash. All rights reserved.
//

import UIKit

class PatientMedsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DataServiceDelegate {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoTxtLbl : UILabel!
    @IBOutlet weak var loadingBG: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //vars
    var dataService = DataService.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dataService.delegate = self
        loadingBG.isHidden = false
        activityIndicator.startAnimating()
        if let ptId = AuthService.instance.id {
            dataService.getPatientMeds(ptId)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.meds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PatientMedsCell") as? PatientMedsCell {
            cell.configureCell(med: dataService.meds[indexPath.row])
            return cell
        } else {
            return MedsCell()
        }
    }
    
    func medsLoaded() {
        OperationQueue.main.addOperation {
            if self.dataService.meds.count > 0 {
                self.infoTxtLbl.isHidden = true
            } else {
                self.infoTxtLbl.isHidden = false
            }
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.loadingBG.isHidden = true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPatientMedsdetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destinVC = segue.destination as! PatientMedDetailVC
            destinVC.selectedRow = indexPath.row
        }
    }
    
    func planLoaded() {
        
    }
    
    func codesLoaded() {
        
    }

    func patientsLoaded() {
        
    }
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        OperationQueue.main.addOperation {
            AuthService.instance.logout()
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }

}
