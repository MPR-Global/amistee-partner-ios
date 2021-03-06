//
//  ScheduleViewModel.swift
//  amistee_partner
//
//  Created by Apple on 20/12/20.
//

import Foundation
import Combine

class ScheduleViewModel: ObservableObject {
    @Published var contractorName: String = "Baban Bandgar"
    @Published var serviceAddress: String = ""
    @Published var city: String = ""
    @Published var phoneNumber: String = "248-345-7921"
    @Published var addressState: String = ""
    @Published var zip: String = ""
    @Published var email: String = "babanb@mprglobalsolutions.com"
    @Published var lossType: String = ""
    @Published var entryType: String = ""
    @Published var homeOwnerName: String = ""
    @Published var homeOwnerContact: String = ""
    @Published var lockBoxCode: String = ""
    @Published var livingSpace: String = ""
    @Published var numberOfFurnace: String = ""
    @Published var cleaningQuote: String = ""
    @Published var serviceDate: Date = Date()
    @Published var arrivalTimeSlot: String = ""
    @Published var associatePO: String = "Yes"
    @Published var emergency: Bool = false
    @Published var anyDryerVent: String = "Yes"
    @Published var PONumber: String = ""
    @Published var message: String = ""
    @Published var reachToOwner: String = "Yes"
    @Published var statusViewModel: StatusViewModel?
    @Published var state: AppState
    
    private var cancellableBag = Set<AnyCancellable>()
    @Published var loading = false
    init(state: AppState) {
        self.state = state
    }
  
    func scheduleJob() {
        self.loading = true
        WebService().scheduleJob(contractorName: contractorName, serviceAddress: serviceAddress, city: city, phoneNumber: phoneNumber, addressState: addressState, zip: zip, email: email, lossType: lossType, entryType: entryType, homeOwnerName: homeOwnerName, homeOwnerContact: homeOwnerContact, lockBoxCode: lockBoxCode, livingSpace: livingSpace, numberOfFurnace: numberOfFurnace, cleaningQuote: cleaningQuote, serviceDate: serviceDate,arrivalTimeSlot: arrivalTimeSlot, emergency: emergency, associatePO: associatePO, anyDryerVent: anyDryerVent, PONumber: PONumber,message: message, reachToOwner: reachToOwner)
                .receive(on: RunLoop.main)
                .map(resultMapper)
                .replaceError(with: StatusViewModel.errorStatus)
                .assign(to: \.statusViewModel, on: self)
                .store(in: &cancellableBag)
    }
}

// MARK: - Private helper function
extension ScheduleViewModel {
    private func resultMapper(with jobState: Int?) -> StatusViewModel {
        self.loading = false
        if jobState != nil {
            return StatusViewModel.scheduleSuccessStatus
        } else {
            return StatusViewModel.errorStatus
        }
    }
}
