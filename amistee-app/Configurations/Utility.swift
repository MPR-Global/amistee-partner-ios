//
//  JobStatus.swift
//  amistee-app
//
//  Created by Apple on 05/01/21.
//

import Foundation

class Utility {
    static func getJobStatus(status: String) -> String{
        switch status {
        case "Open: New":
            return "Scheduled"
        case "Open: Scheduled":
            return "Your Appointment is Soon"
        case "Open: On Way Call":
            return "Arriving Soon"
        case "Open: Missing Pictures":
            return "Uploading Pictures"
        case "Open: Ready for Billing":
            return "Job Completed"
        case "Open: Billed":
            return "Billed"
        default:
            return status
        }
    }
}
