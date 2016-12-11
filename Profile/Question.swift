//
//  question.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-10.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import Foundation

class Question {
    var title : String = ""
    var text = ""
    var id = ""
    
    static func parseQuestionJSONData(data: Data) -> [Question] {
        var questionsArr = [Question]()
        
        do {
            
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let questions = jsonResult as? [Dictionary<String, AnyObject>] {
                for question in questions {
                    let newQuestion = Question()
                    newQuestion.id = question["_id"] as! String
                    newQuestion.title = question["title"] as! String
                    newQuestion.text = question["text"] as! String
                    
                    questionsArr.append(newQuestion)
                }
            }
            
        } catch let err {
            print(err)
        }
        
     return questionsArr
    }
}
