//
//  HomeView.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import SwiftUI

enum PageSelector {
    case home
    case schedule
    case estimate
    case contact
}

struct HomeView: View {
    @ObservedObject var state: AppState
    @State var show: Bool = false
    @State var pageSelector: PageSelector = .home
    
    var body: some View {
        ZStack {
            //MARK:-  Menu
            DrawerView(isShow: self.$show, pageSelector: self.$pageSelector)
            
            //MARK:- MainView
            
            VStack(spacing: 0){
                HStack(spacing: 15){
                    Button(action: {
                        withAnimation{
                            self.show.toggle()
                        }
                    }){
                       Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 22, height: 18)
                        .foregroundColor(Color("button").opacity(0.4))
                    }
                    Text(navTitle())
                        .font(.title)
                        .foregroundColor(Color("button").opacity(0.6))
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding()
                
                GeometryReader{_ in
                    VStack{
                        switchContent(show: show)
                    }
                }
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .background(Color("primary"))
            .scaleEffect(self.show ? 0.9 : 1)
            .offset(x: self.show ? UIScreen.main.bounds.width / 1.7 : 0)
            .animation(.default)
        }
        .background(Color("menu"))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
    }
    
    
    // Switching pages (views)
    func switchContent(show: Bool) -> AnyView {
        switch pageSelector {
        case .home:
            return AnyView(JobsView())
        case .schedule:
            return AnyView(ScheduleView(state: AppState()))
        case .estimate:
            return AnyView(SignUpView(state: AppState()))
        case .contact:
            return AnyView(SignInView(state: AppState()))
        }
    }
    
    func navTitle() -> String {
        switch pageSelector {
        case .home:
            return "Home"
        case .schedule:
            return "Schedule Job"
        case .estimate:
            return "Insulation Estimate"
        case .contact:
            return "Contact Us"
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(state: AppState())
            .previewDevice("iPhone X")
    }
}
#endif
