//
//  SignInView.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import SwiftUI
import Combine

struct SignInView: View {
    @State var pushActive = false
    @State var isShowingPassword = false
    @ObservedObject private var viewModel: SignInViewModel
    
    init(state: AppState) {
        self.viewModel = SignInViewModel(authAPI: AuthService(), state: state)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary").edgesIgnoringSafeArea(.all)
                VStack {
                    NavigationLink(destination: HomeView(state: viewModel.state),
                                   isActive: self.$pushActive) {
                        EmptyView()
                    }.hidden()
                    VStack(alignment: .leading, spacing: 30) {
                        if (self.viewModel.isAuthenticating) {
                            GeometryReader { geometry in
                                ZStack(alignment: .center) {
                                    Loader()
                                }
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height)
                            }
                        }else {
                            Text("Log in")
                                .modifier(TextModifier(font: UIConfiguration.titleFont,
                                                       color: UIConfiguration.tintColor))
                                .padding(.leading, 25)
                                .padding(.bottom, 80)
                            VStack(alignment: .center, spacing: 30) {
                                VStack(alignment: .center, spacing: 25) {
                                    CustomTextField(placeHolderText: "Cell Number",
                                                    text: $viewModel.mobile)
                                    
                                    CustomTextField(placeHolderText: "Password",
                                                    text: $viewModel.password,
                                                    isPasswordType: !isShowingPassword)
                                    
                                    Toggle("Show password", isOn: $isShowingPassword)
                                        .foregroundColor(.white)
                                    
                                }.padding(.horizontal, 25)
                                
                                VStack(alignment: .center, spacing: 40) {
                                    customButton(title: "Log In",
                                                 backgroundColor: UIConfiguration.tintColor,
                                                 action: { self.viewModel.login() })
                                }
                            }
                        }
                    }
                    Spacer()
                }.alert(item: self.$viewModel.statusViewModel) { status in
                    Alert(title: Text(status.title),
                          message: Text(status.message),
                          dismissButton: .default(Text("OK"), action: {
//                            if status.title == "Successful" {
                                self.pushActive = true
//                            }
                          }))
                }
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
                                         height: 55))
        }
    }
}

#if DEBUG
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(state: AppState())
            .previewDevice("iPhone X")
    }
}
#endif
