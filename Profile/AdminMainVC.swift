//
//  AdminMainVC.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-28.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import UIKit

class AdminMainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DataServiceDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var dataService = DataService.instance
    var filteredPatients = [Patient]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dataService.delegate = self
        searchBar.delegate = self
        dataService.getAllPatients()
        searchBar.returnKeyType = .done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPatients.count
        }
        return dataService.patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "patientCell", for: indexPath) as? PatientCell {
            var patient : Patient!
            if inSearchMode {
                patient = filteredPatients[indexPath.row]
            } else {
                patient = dataService.patients[indexPath.row]
            }
            cell.configureCell(patient: patient)
            return cell
        }
        return UITableViewCell()
    }

    func patientsLoaded() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    func codesLoaded() {
        //nothing to do here
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            inSearchMode = true
            let lowerCaseTxt = searchBar.text!.lowercased()
            filteredPatients = dataService.patients.filter({$0.lastName.range(of: lowerCaseTxt) != nil })
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

}
