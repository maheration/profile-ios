//
//  AdminMedsVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-30.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class AdminMedsVC: UIViewController, DataServiceDelegate, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet weak var infoTxt: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var updateLbl: UILabel!
    
    //vars
    var dataService = DataService.instance
    var patientId : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        infoTxt.isHidden = false
        addBtn.isHidden = false
        updateLbl.isHidden = true
        if let ptId = patientId {
            dataService.getPatientMeds(ptId)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func addBtnPressed(_ sender: UIButton) {
    }
    
    
    func patientsLoaded() {
        //nothing
    }
    
    
    func codesLoaded() {
        //nothing
    }
    
    func planLoaded() {
        //nothing
    }
    
    func medsLoaded() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
            if self.dataService.meds.count > 0 {
                self.addBtn.isHidden = true
                self.infoTxt.isHidden = true
                self.updateLbl.isHidden = false
            } else {
                self.addBtn.isHidden = false
                self.infoTxt.isHidden = false
                self.updateLbl.isHidden = true
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.meds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MedsCell") as? MedsCell {
            cell.configureCell(meds: dataService.meds[indexPath.row])
            return cell
        } else {
            return MedsCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminMedsDetailVC" {
            var med : Medication?
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            med = dataService.meds[indexPath.row]
            let destinVC = segue.destination as! AdminMedsDetailVC
            destinVC.transMeds = med
        }
    }
    
}
