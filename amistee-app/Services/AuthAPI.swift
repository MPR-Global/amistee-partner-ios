//
//  AuthAPI.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import Foundation
import Combine

protocol AuthAPI {
    func login(mobile: String, password: String) -> Future<User?, Never>
    func signUp(email: String, password: String) -> Future<User?, Never>
}
