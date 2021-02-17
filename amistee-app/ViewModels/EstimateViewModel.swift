//
//  EstimateViewModel.swift
//  amistee-app
//
//  Created by Apple on 13/02/21.
//

import Foundation
import Combine

class EstimateViewModel: ObservableObject {
    @Published var contractorName: String = "Baban Bandgar"
    @Published var serviceAddress: String = ""
    @Published var city: String = ""
    @Published var phoneNumber: String = "248-345-7921"
    @Published var addressState: String = ""
    @Published var zip: String = ""
    @Published var email: String = "babanb@mprglobalsolutions.com"
    @Published var insulationType: String = ""
    @Published var entryType: String = ""
    @Published var areaToEstimate: String = ""
    @Published var homeOwnerName: String = ""
    @Published var homeOwnerContact: String = ""
    @Published var lockBoxCode: String = ""
    @Published var completionDate: Date = Date()
    @Published var isLadderGreater: String = "Yes"
    @Published var message: String = ""
    @Published var statusViewModel: StatusViewModel?
    @Published var state: AppState
    
    private var cancellableBag = Set<AnyCancellable>()
    @Published var loading = false
    init(state: AppState) {
        self.state = state
    }
  
    func scheduleInsulationJob() {
        self.loading = true
        WebService().insulationEstimate(contractorName: contractorName, serviceAddress: serviceAddress, city: city, phoneNumber: phoneNumber, addressState: addressState, zip: zip, email: email, insulationType: insulationType, areaToEstimate: areaToEstimate, entryType: entryType, homeOwnerName: homeOwnerName, homeOwnerContact: homeOwnerContact, lockBoxCode: lockBoxCode, message: message, completionDate: completionDate, isLadderGreater: isLadderGreater)
                .receive(on: RunLoop.main)
                .map(resultMapper)
                .replaceError(with: StatusViewModel.errorStatus)
                .assign(to: \.statusViewModel, on: self)
                .store(in: &cancellableBag)
    }
}

// MARK: - Private helper function
extension EstimateViewModel {
    private func resultMapper(with jobState: Int?) -> StatusViewModel {
        self.loading = false
        if jobState != nil {
            return StatusViewModel.insulationSuccessStatus
        } else {
            return StatusViewModel.errorStatus
        }
    }
}
