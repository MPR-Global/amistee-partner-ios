//
//  WelcomeView.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var index = 1
    @State private var pushActive = false
    @ObservedObject var state: AppState
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary").edgesIgnoringSafeArea(.all)
            VStack {
                NavigationLink(destination: destinationView(),
                               isActive: self.$pushActive) {
                                EmptyView()
                }
                .navigationBarHidden(true)
                
                VStack(spacing: 40) {
                    Image("logo")
                        .resizable()
                        .frame(width: 180, height: 110, alignment: .center)
                        .padding(.top, 100)
                    
                    Text("Welcome to Amistee")
                        .modifier(TextModifier(font: UIConfiguration.titleFont,
                                               color: UIConfiguration.tintColor))
                    
                    VStack(spacing: 25) {
                        Button(action: {
                            self.index = 1
                            self.pushActive = true
                        }) {
                            Text("Log In")
                                .modifier(ButtonModifier(font: UIConfiguration.buttonFont,
                                                         color: UIConfiguration.tintColor,
                                                         textColor: .white,
                                                         width: 275,
                                                         height: 55))
                        }
                        Button(action: {
                            self.index = 2
                            self.pushActive = true
                        }) {
                            Text("Sign Up")
                                .modifier(ButtonModifier(font: UIConfiguration.buttonFont,
                                                         color: .white,
                                                         textColor: UIConfiguration.tintColor,
                                                         width: 275,
                                                         height: 55))
                        }
                    }
                }
                Spacer()
            }
        }
        }.accentColor(.white)

    }
    
    private func destinationView() -> AnyView {
        switch index {
        case 1:
            return AnyView(SignInView(state: state))
        default:
            return AnyView(SignUpView(state: state))
        }
    }
}

#if DEBUG
struct WelcomeView_Previews: PreviewProvider {
   static var previews: some View {
    WelcomeView(state: AppState())
      .previewDevice("iPhone X")
   }
}
#endif
