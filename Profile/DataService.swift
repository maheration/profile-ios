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
    func medsLoaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    var codes = [Codes]()
    var patients = [Patient]()
    var plans = [Plan]()
    var meds = [Medication]()
    
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
    
    
    //POST a new plan
    
    func postNewPlan(_ id: String, dx: String, plan: String, labs: String, completion: @escaping callback) {
        let json : [String: Any] = ["dx": dx, "plan": plan, "labs": labs]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            guard let url = URL(string: "\(GET_PT_PLAN)/\(id)/add") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            guard let token = AuthService.instance.authToken else { return }
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if (error == nil) {
                    //success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("Status code is \(statusCode)")
                    if statusCode != 200 {
                        completion(false)
                        return
                    } else {
                        completion(true)
                        self.getPatientPlan(id)
                    }
                } else {
                    //Failure
                    print("URL SESSION failed HTTP: \(error!.localizedDescription)")
                    completion(false)
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
            
        } catch let err {
            print(err)
            completion(false)
        }
    }
    
    //PUT a new plan
    func updatePlan(_ id: String, dx: String, plan: String, labs: String, completion: @escaping callback) {
        let json : [String: Any] = ["dx": dx, "plan": plan, "labs": labs]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            guard let url = URL(string: "\(GET_PT_PLAN)/\(id)") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            guard let token = AuthService.instance.authToken else { return }
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if (error == nil) {
                    //success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("Status code \(statusCode)")
                    if statusCode != 200 {
                        completion(false)
                        return
                    } else {
                        completion(true)
                        self.getPatientPlan(id)
                    }
                } else {
                    //Failure
                    print("URL Session failed: \(error!.localizedDescription)")
                    completion(false)
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
        } catch let err {
            print(err)
            completion(false)
        }
    }
    

    func getPatientMeds(_ id: String) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let url = URL(string: "\(GET_PT_MEDS)/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = AuthService.instance.authToken else { return }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("Status code ya getMed \(statusCode)")
                if let dataa = data {
                    self.meds = Medication.parseMedicationJSONData(data: dataa)
                    self.delegate?.medsLoaded()
                }
            } else {
                //Failure
                print("URL session failed \(error!.localizedDescription)")
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    //POST a new med
    
    func addNewMed(_ id: String, name: String, disc: String, completion: @escaping callback) {
        let json : [String: Any] = ["name": name, "disc": disc]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            guard let url = URL(string: "\(GET_PT_MEDS)/\(id)/add") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            guard let token = AuthService.instance.authToken else { return }
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if (error == nil) {
                    //success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    if statusCode != 200 {
                        completion(false)
                        return
                    } else {
                        completion(true)
                        self.getPatientMeds(id)
                    }
                } else {
                    //Failure
                    print("URL session fauled HTTP: \(error!.localizedDescription)")
                    completion(true)
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
            
        } catch let err {
            print(err)
            completion(false)
        }
    }
    
    //PUT a med
    func updateMed(_ medId: String, patientId:String, name: String, disc: String, completion: @escaping callback) {
        let json : [String: Any] = ["name": name, "disc": disc]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let sessionConfig = URLSessionConfiguration.default
            let session =  URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            guard let url = URL(string: "\(GET_PT_MEDS)/\(medId)") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            guard let token = AuthService.instance.authToken else { return }
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if (error == nil) {
                    //success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    if statusCode != 200 {
                        completion(false)
                        return
                    } else {
                        completion(true)
                        self.getPatientMeds(patientId)
                    }
                } else {
                    //failure
                    print("URL session failed: \(error!.localizedDescription)")
                    completion(false)
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
        } catch let err {
            print(err)
            completion(false)
        }
    }
    
    //DELETE a med
    func deleteMed(_ medId: String) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        guard let url = URL(string: "\(GET_PT_MEDS)/\(medId)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        guard let token = AuthService.instance.authToken else { return }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if (error == nil) {
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("status code \(statusCode)")

            } else {
                // failed to delete
                print("\(error!.localizedDescription)")
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    
    
    
    
}
