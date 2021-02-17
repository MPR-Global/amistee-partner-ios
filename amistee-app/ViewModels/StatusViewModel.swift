//
//  StatusViewModel.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import Foundation

class StatusViewModel: Identifiable, ObservableObject {
    
    var title: String
    var message: String
    
    init(title: String = "", message: String = "") {
        self.title = title
        self.message = message
    }
    
    static var signUpSuccessStatus: StatusViewModel {
        return StatusViewModel(title: "Successful", message: "Your account has been created successfully")
    }
    
    static var scheduleSuccessStatus: StatusViewModel {
        return StatusViewModel(title: "Successful", message: "Service request has been received.")
    }
    
    static var insulationSuccessStatus: StatusViewModel {
        return StatusViewModel(title: "Successful", message: "Insulation estimation reqquest has been received.")
    }
    
    static var logInSuccessStatus: StatusViewModel {
        return StatusViewModel(title: "Successful", message: "Your account has been logged in successfully")
    }
    
    static var errorStatus: StatusViewModel {
        return StatusViewModel(title: "Error", message: "Oops! Something went wrong. Please try again.")
    }
}
