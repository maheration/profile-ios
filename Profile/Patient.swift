//
//  Patient.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-29.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import Foundation

class Patient {
    var firstName = ""
    var lastName = ""
    var id = ""
    var username = ""
    var fullName : String {
        get {
            return firstName.capitalized + " " + lastName.capitalized
        }
    }
    
    static func parsePatientsJSONData(data: Data) -> [Patient] {
        var patientArr = [Patient]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let patients = jsonResult as? [Dictionary<String, AnyObject>] {
                for patient in patients {
                    let newPatient = Patient()
                    newPatient.firstName = patient["firstName"] as! String
                    newPatient.lastName = patient["lastName"] as! String
                    newPatient.id = patient["_id"] as! String
                    newPatient.username = patient["username"] as! String
                    patientArr.append(newPatient)
                }
            }
            
        } catch let err {
            print(err)
        }
        
        return patientArr
    }
    
}
