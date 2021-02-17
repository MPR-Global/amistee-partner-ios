//
//  TicketListViewModel.swift
//  amistee_partner
//
//  Created by Apple on 26/12/20.
//

import Foundation
import Combine
import SwiftUI

class TicketListViewModel: ObservableObject {
    
    @Published var jobs = JobList(results: [])
    @Published var loading = false
    @Published var error = ""
    init() {
        loading = true
        fetchJobs()
    }
    
    
    private func fetchJobs() {
        WebService().getAllJobs { result in
            switch result {
              case .succeed(let data):
              self.jobs = data
              self.loading = false
              case .failed(let error):
                self.loading = false
                print("error getting job list \(error)")
                self.error = "Something went wrong"
              }
        }
    }
}
