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
    func patientsLoaded()
    func planLoaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    var codes = [Codes]()
    var patients = [Patient]()
    var plans = [Plan]()
    
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
    
    //GET all patients
    func getAllPatients() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let url = URL(string: GET_ALL_PTS) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = AuthService.instance.authToken else { return }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session success: HTTP \(statusCode)")
                if let data = data {
                    self.patients = Patient.parsePatientsJSONData(data: data)
                    self.delegate?.patientsLoaded()
                }
            } else {
                //Failure
                print("Url session task failed: \(error!.localizedDescription)")
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    // GET a patient's plan
    func getPatientPlan(_ id: String) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let url = URL(string: "\(GET_PT_PLAN)/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = AuthService.instance.authToken else { return }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if (error == nil) {
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL session success HTTP: \(statusCode)")
                if let data = data {
                    self.plans = Plan.parsePlanJSONData(data: data)
                    self.delegate?.planLoaded()
                }
                
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    
    
    
}
