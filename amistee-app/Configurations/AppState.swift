//
//  AppState.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var user: User?
    var currentUser: User?
}
