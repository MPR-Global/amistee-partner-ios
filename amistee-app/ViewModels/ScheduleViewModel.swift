//
//  ScheduleViewModel.swift
//  amistee_partner
//
//  Created by Apple on 20/12/20.
//

import Foundation
import Combine

class ScheduleViewModel: ObservableObject {
    @Published var contractorName: String = ""
    @Published var serviceAddress: String = ""
    @Published var city: String = ""
    @Published var phoneNumber: String = ""
    @Published var addressState: String = ""
    @Published var zip: String = ""
    @Published var email: String = ""
    @Published var lossType: String = ""
    @Published var entryType: String = ""
    @Published var lockBoxCode: String = ""
    @Published var furnaceSize: String = ""
    @Published var numberOfFurnace: String = ""
    @Published var cleaningQuote: String = ""
    @Published var serviceDate: Date = Date()
    @Published var associatePO: String = "Yes"
    @Published var anyDryerVent: String = "Yes"
    @Published var PONumber: String = ""
    @Published var reachToOwner: String = "Yes"
    @Published var statusViewModel: StatusViewModel?
    @Published var state: AppState
    
    private var cancellableBag = Set<AnyCancellable>()
    private let authAPI: AuthAPI
    
    init(authAPI: AuthAPI, state: AppState) {
        self.authAPI = authAPI
        self.state = state
    }
    
    func scheduleJob() {
            authAPI.signUp(email: email, password: phoneNumber)
                .receive(on: RunLoop.main)
                .map(resultMapper)
                .replaceError(with: StatusViewModel.errorStatus)
                .assign(to: \.statusViewModel, on: self)
                .store(in: &cancellableBag)
    }
}

// MARK: - Private helper function
extension ScheduleViewModel {
    private func resultMapper(with user: User?) -> StatusViewModel {
        if user != nil {
            state.currentUser = user
            return StatusViewModel.scheduleSuccessStatus
        } else {
            return StatusViewModel.errorStatus
        }
    }
}
