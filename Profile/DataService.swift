//
//  DataService.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-27.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import Foundation

protocol DataServiceDelegate: class {
    func codesLoaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    var codes = [Codes]()
    
    
    //GET all codes 
    func getAllCodes() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: GET_ALL_CODES) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
        
            if (error == nil) {
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL session task succeeded: HTTP \(statusCode)")
                if let data = data {
                    self.codes = Codes.parseCodesJSONData(data: data)
                    self.delegate?.codesLoaded()
                }
            } else {
                //Failure
                print("URL session task failed: \(error!.localizedDescription)")
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
}
