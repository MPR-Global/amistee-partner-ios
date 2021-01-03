//
//  User.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import Foundation

struct User: Decodable {
    let id: String
    let email: String
    let contractor_name: String
    let company_name: String
    let business_name: String
    let mob_number: String
}
