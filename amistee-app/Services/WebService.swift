//
//  WebService.swift
//  amistee_partner
//
//  Created by Apple on 26/12/20.
//

import Foundation

class WebService {
    private let api_url_base = "https://us-central1-amistee-72b71.cloudfunctions.net/webApi/"
    
    func getAllJobs(completion: @escaping (JobList) -> ()){
        guard  let url = URL(string: "\(api_url_base)jobs/23617632") else { return }
        
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let tickets = try! JSONDecoder().decode(JobList.self, from: data)
            print("resposne from api \(tickets)")
            DispatchQueue.main.async {
                completion(tickets)
            }
        }.resume()
    }
}
