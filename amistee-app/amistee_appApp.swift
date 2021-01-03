//
//  amistee_appApp.swift
//  amistee-app
//
//  Created by Apple on 26/12/20.
//

import SwiftUI

@main
struct amistee_appApp: App {
//    let authState = AuthenticationState.shared
    var body: some Scene {
        WindowGroup {
            SplashView(state: AppState())
//                .environmentObject(authState)
        }
    }
}
