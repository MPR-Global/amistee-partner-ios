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
    init() {
        loading = true
        fetchJobs()
    }
    
    
    private func fetchJobs() {
        WebService().getAllJobs {

            self.jobs = $0
            self.loading = false
        }
    }
}
