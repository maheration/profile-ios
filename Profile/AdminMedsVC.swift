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
    @IBOutlet weak var tableView: UITableView!
    
    //vars
    var dataService = DataService.instance
    var patientId : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        infoTxt.isHidden = false
        if let ptId = patientId {
            dataService.getPatientMeds(ptId)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Maher")
        tableView.reloadData()

    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        print("did appear")
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
        performSegue(withIdentifier: "showAddMedVC", sender: self)
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
            print("Meds Loaded")
            if self.dataService.meds.count > 0 {
                self.infoTxt.isHidden = true
            } else {
                self.infoTxt.isHidden = false
            }
            self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let medId = dataService.meds[indexPath.row].id
            dataService.meds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            dataService.deleteMed(medId)
            
            if self.dataService.meds.count > 0 {
                self.infoTxt.isHidden = true
            } else {
                self.infoTxt.isHidden = false
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminMedsDetailVC" {
            var med : Medication?
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            med = dataService.meds[indexPath.row]
            let destinVC = segue.destination as! AdminMedsDetailVC
            destinVC.transMeds = med
            destinVC.selectedRow = indexPath.row
            destinVC.patientId = self.patientId
        }
        
        if segue.identifier == "showAddMedVC" {
            let destinVC = segue.destination as! AddMedVC
            if let id = patientId {
                destinVC.patientId = id
            }
        }
    }
    
}
