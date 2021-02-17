//
//  Ticket.swift
//  amistee_partner
//
//  Created by Apple on 26/12/20.
//

import Foundation
import SwiftUI

struct TicketList: Decodable {
    var results: [Ticket]
}


struct Ticket: Decodable, Identifiable, Hashable {
    
    var ticketId: Int32
    var ticketStatus:String
    var serviceLocation: String?
    var summary: String?
    var creationDate: String?
    var id: Int?
}


enum TicketStatus {
    case home
    case schedule
    case estimate
    case contact
}
