//
//  WebService.swift
//  amistee_partner
//
//  Created by Apple on 26/12/20.
//

import Foundation
import Combine
import Alamofire

public enum Result<Success, Failure> where Failure : Error {
    case succeed(Success)
    case failed(Failure)
}
    
class WebService {
    private let api_url_base = "https://us-central1-amistee-72b71.cloudfunctions.net/webApi/"
    func getAllJobs(completion: @escaping (Result<JobList, Error>) -> ()){
        guard  let url = URL(string: "\(api_url_base)jobs/23617632") else { return }
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
            .responseJSON { response in
                DispatchQueue.main.async {
                    switch (response.result) {
                        case .success( _):
                        do {
                            let list = try JSONDecoder().decode(JobList.self, from: response.data!)
                            completion(.succeed(list))
                        } catch let error as NSError {
                           print("Failed to load: \(error.localizedDescription)")
                            completion(.failed(error))
                       }
                        case .failure(let error):
                           print("Request error: \(error.localizedDescription)")
                            completion(.failed(error))
                    }
                    
                }
            }
        
    }
    
    func scheduleJob(contractorName: String, serviceAddress: String, city: String, phoneNumber: String, addressState: String, zip: String, email: String, lossType: String, entryType: String, homeOwnerName: String, homeOwnerContact: String, lockBoxCode: String, livingSpace: String, numberOfFurnace: String, cleaningQuote: String, serviceDate: Date,arrivalTimeSlot: String, emergency: Bool, associatePO: String, anyDryerVent: String, PONumber: String, message: String, reachToOwner: String) -> Future<Int?, Never> {
        return Future<Int?, Never> { promise in
            guard  let url = URL(string: "\(self.api_url_base)schedule") else { return }
            print("Schedule api url =\(url)")
            
             let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY/MM/DD"
            
            AF.request(url,
                       method: .post,
                       parameters: ["contractorName" : contractorName, "serviceLocation" : "\(serviceAddress), \(city), \(addressState), - \(zip)",
                                    "phoneNumber": phoneNumber, "email": email, "lockBoxCode": lockBoxCode, "lossType": lossType, "entryType": entryType,
                                    "homeOwnerName": homeOwnerName, "homeOwnerContact": homeOwnerContact, "livingSpace": livingSpace,
                                    "numberOfFurnace": numberOfFurnace, "cleaningQuote": cleaningQuote,"serviceDate": dateFormatter.string(from: serviceDate), "arrivalTimeSlot":arrivalTimeSlot,"emergency": emergency, "associatePO": associatePO, "PONumber": PONumber, "message": message, "reachToOwner": reachToOwner, "addDryerVent": anyDryerVent],
                       encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    print("schedule response \(response)")
                    if response.value != nil {
                        promise(.success(1))
                    }else {
                        promise(.success(nil))
                        return
                    }
                }
            
        }
        
    }
    
    
    func insulationEstimate(contractorName: String, serviceAddress: String, city: String, phoneNumber: String, addressState: String, zip: String, email: String, insulationType: String,areaToEstimate: String, entryType: String, homeOwnerName: String, homeOwnerContact: String, lockBoxCode: String, message: String, completionDate: Date, isLadderGreater: String) -> Future<Int?, Never> {
        return Future<Int?, Never> { promise in
            guard  let url = URL(string: "\(self.api_url_base)scheduleInsulationEstimate") else { return }
            print("Schedule api url =\(url)")
            
             let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY/MM/DD"
            
            AF.request(url,
                       method: .post,
                       parameters: ["contractorName" : contractorName, "serviceLocation" : "\(serviceAddress), \(city), \(addressState), - \(zip)",
                                    "phoneNumber": phoneNumber, "email": email, "areaToEstimate": areaToEstimate, "lockBoxCode": lockBoxCode, "insulationType": insulationType, "entryType": entryType, "homeOwnerName": homeOwnerName, "homeOwnerContact": homeOwnerContact, "message": message, "completionDate": dateFormatter.string(from: completionDate), "isLadderGreater": isLadderGreater],
                       encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    print("schedule response \(response)")
                    if response.value != nil {
                        promise(.success(1))
                    }else {
                        promise(.success(nil))
                        return
                    }
                }
            
        }
        
    }
    
    
    func getEstimate(zip: String, livingSpace: String, numberOfFurnace: String, anyDryerVent: String, phoneNumber: String, completion: @escaping (Estimate) -> ()){
        
        guard  let url = URL(string: "\(self.api_url_base)getEsitmates") else { return }
        print("login api url =\(url)")
        let dryerVent = anyDryerVent == "Yes" ? anyDryerVent : ""
        print("Calling estimate api, numberOfFurnace =\(numberOfFurnace), dryerVent =\(dryerVent), living_space =\(livingSpace), mobile_number =\(phoneNumber), zip =\(zip)")
        AF.request(url,
                   method: .post,
                   parameters: ["no_of_furnace" : numberOfFurnace, "dryer_vent": dryerVent, "living_space": livingSpace, "mobile_number": phoneNumber, "zipcode": zip],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch (response.result) {
                    case .success( _):
                    do {
                        let estimates = try JSONDecoder().decode(Estimate.self, from: response.data!)
                        DispatchQueue.main.async {
                            completion(estimates)
                        }
                    } catch let error as NSError {
                       print("Failed to load estimates: \(error.localizedDescription)")
                        return
                   }

                    case .failure(let error):
                       print("Request error: \(error.localizedDescription)")
                        return
                }
            }
    }
}
