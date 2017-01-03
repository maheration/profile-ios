//
//  Medication.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-26.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import Foundation

class Medication {
    var name : String = ""
    var disc : String = ""
    var id = ""
    
    static func parseMedicationJSONData(data: Data) -> [Medication] {
        var medsArr = [Medication]()
        
        do {
            
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let meds = jsonResult as? [Dictionary<String, AnyObject>] {
                for med in meds {
                    let newMed = Medication()
                    newMed.name = med["name"] as! String
                    newMed.disc = med["disc"] as! String
                    newMed.id = med["_id"] as! String
                    
                    medsArr.append(newMed)
                }
            }
            
        } catch let err {
            print(err)
        }
        return medsArr
    }
}
