//
//  plan.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-10.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import Foundation

class Plan {
    var dx = ""
    var labs = ""
    var plan = ""
    var id = ""
    
    static func parsePlanJSONData(data: Data) -> [Plan] {
        var planArr = [Plan]()
        
        do {
            
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let plans = jsonResult as? [Dictionary<String,AnyObject>] {
              
                for plan in plans {
                    let newPlan = Plan()
                    newPlan.id = plan["_id"] as! String
                    newPlan.dx = plan["dx"] as! String
                    newPlan.plan = plan["plan"] as! String
                    newPlan.labs = plan["labs"] as! String
                    
                    planArr.append(newPlan)
                }
                
            }
            
        } catch let err {
            print(err)
        }
        return planArr
    }
    
}
