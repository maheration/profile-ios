//
//  Answer.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-10.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import Foundation

class Answer {
    
    var text = ""
    
    static func parseAnswerJSONData(data: Data) -> [Answer] {
        var answerArr = [Answer]()
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let answers = jsonResult as? [Dictionary<String, AnyObject>] {
                for answer in answers {
                    let newAnswer = Answer()
                    newAnswer.text = answer["text"] as! String
                    answerArr.append(newAnswer)
                }
            }
            
            
        } catch let err {
            print(err)
        }
     return answerArr
    }
    
}
