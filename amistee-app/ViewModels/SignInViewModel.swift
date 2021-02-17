//
//  SignInViewModel.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import Combine

class SignInViewModel: ObservableObject {
    @Published var mobile: String = ""
    @Published var password: String = ""
    @Published var statusViewModel: StatusViewModel?
    @Published var state: AppState
    @Published var isAuthenticating = false

    private var cancellableBag = Set<AnyCancellable>()
    private let authAPI: AuthAPI
    
    init(authAPI: AuthAPI, state: AppState) {
        self.authAPI = authAPI
        self.state = state
    }
    
    func login() {
        self.isAuthenticating = true
        print("inside login view model, login creds = \(mobile) pass=\(password)")
        authAPI.login(mobile: mobile, password: password)
//            .receive(on: RunLoop.main)
            .map(resultMapper)
            .replaceError(with: StatusViewModel.errorStatus)
            .assign(to: \.statusViewModel, on: self)
            .store(in: &cancellableBag)
    }
    
}

// MARK: - Private helper function
extension SignInViewModel {
    private func resultMapper(with user: User?) -> StatusViewModel {
        isAuthenticating = false
        if user != nil {
            state.currentUser = user
            return StatusViewModel.logInSuccessStatus
        } else {
            return StatusViewModel.logInSuccessStatus
        }
    }
}
