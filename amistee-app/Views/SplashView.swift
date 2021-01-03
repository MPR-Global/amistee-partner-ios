//
//  SplashView.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import SwiftUI

struct SplashView: View {
    @State var isActive:Bool = false
    @ObservedObject var state: AppState
//    @EnvironmentObject var authState: AuthenticationState

    var body: some View {
        VStack {
            if self.isActive {
                Group {
                    if state.user != nil {
                        HomeView(state: state)
                    }else{
                        SignInView(state: state)
                    }
                }
                .animation(.easeInOut)
                .transition(.move(edge: .bottom))
            } else {
                ZStack {
                    Color("primary")
                        .edgesIgnoringSafeArea(.all)
                    Image("logo")
                        .resizable()
                        .frame(width: 380, height: 210, alignment: .center)
                }
            }
        }
        .background(Color("primary"))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#if DEBUG
struct SplashView_Previews: PreviewProvider {
   static var previews: some View {
    SplashView(state: AppState())
      .previewDevice("iPhone X")
   }
}
#endif
