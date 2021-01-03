//
//  AuthenticationState.swift
//  amistee-app
//
//  Created by Apple on 28/12/20.
//

import Foundation

class AuthenticationState: NSObject, ObservableObject {

    @Published var loggedInUser: User?
    @Published var isAuthenticating = false
    @Published var error: NSError?

    static let shared = AuthenticationState()

//    private let auth = Auth.auth()
//    fileprivate var currentNonce: String?
//
//    func login(with loginOption: LoginOption) {
//        self.isAuthenticating = true
//        self.error = nil
//
//        switch loginOption {
//            case .signInWithApple:
//                handleSignInWithApple()
//
//            case let .emailAndPassword(email, password):
//                handleSignInWith(email: email, password: password)
//        }
//    }

    func signup(email: String, password: String, passwordConfirmation: String) {
        // TODO
    }

    private func handleSignInWith(email: String, password: String) {
        // TODO
    }

    private func handleSignInWithApple() {
        // TODO
    }
}
