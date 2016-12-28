//
//  Codes.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-27.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import Foundation

class Codes {
    var id = ""
    var code = ""
    var role = ""
    var taken = ""
    
    static func parseCodesJSONData(data: Data) -> [Codes] {
        var codesArr = [Codes]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let codes = jsonResult as? [Dictionary<String, AnyObject>] {
                for code in codes {
                    let newCode = Codes()
                    newCode.id = code["_id"] as! String
                    newCode.code = code["code"] as! String
                    newCode.role = code["role"] as! String
                    newCode.taken = code["taken"] as! String
                    
                    codesArr.append(newCode)
                }
            }
        } catch let err {
            print(err)
        }
        return codesArr
    }
}
