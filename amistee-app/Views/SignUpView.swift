//
//  SignUpView.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject private var viewModel: SignUpViewModel
    @State var pushActive = false
    
    init(state: AppState) {
        self.viewModel = SignUpViewModel(authAPI: AuthService(), state: state)
    }
    
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
        VStack {
            NavigationLink(destination: HomeView(state: viewModel.state),
                           isActive: self.$pushActive) {
              EmptyView()
            }.hidden()
            VStack(alignment: .leading, spacing: 30) {
                Text("Sign Up")
                    .modifier(TextModifier(font: UIConfiguration.titleFont,
                                           color: UIConfiguration.tintColor))
                    .padding(.leading, 25)
                VStack(alignment: .center, spacing: 30) {
                    VStack(alignment: .center, spacing: 25) {
                        CustomTextField(placeHolderText: "Contractor Name",
                                      text: $viewModel.fullName)
                        CustomTextField(placeHolderText: "Business Name",
                                      text: $viewModel.email)
                        CustomTextField(placeHolderText: "Cell Number",
                                      text: $viewModel.phoneNumber)
//                        CustomTextField(placeHolderText: "Password",
//                                      text: $viewModel.password,
//                                      isPasswordType: true)
                    }.padding(.horizontal, 25)
                    
                    VStack(alignment: .center, spacing: 40) {
                        customButton(title: "Create Account",
                                     backgroundColor: UIConfiguration.tintColor,
                                     action: self.viewModel.signUp)
                    }
                }
            }
            Spacer()
        }
        .alert(item: self.$viewModel.statusViewModel) { status in
            Alert(title: Text(status.title),
                  message: Text(status.message),
                  dismissButton: .default(Text("OK"), action: { self.pushActive = true }))
        }
        }
    }
    
    private func customButton(title: String,
                              backgroundColor: UIColor,
                              action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .modifier(ButtonModifier(font: UIConfiguration.buttonFont,
                                         color: backgroundColor,
                                         textColor: .white,
                                         width: 275,
                                         height: 45))
        }
    }
}

#if DEBUG
struct SignUpView_Previews: PreviewProvider {
   static var previews: some View {
    SignUpView(state: AppState())
      .previewDevice("iPhone X")
   }
}
#endif
