//
//  DrawerView.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//


import SwiftUI

struct DrawerView: View {
    @Binding var isShow: Bool
    @Binding var pageSelector: PageSelector
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12){
                Image(systemName: "person.circle")
                    .font(.system(size: 60, weight: .thin))
                    .foregroundColor(Color("button") )
                
                Text("Hi")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
//                    Text("Baban")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
                
                Button(action: {
                    
                    self.pageSelector = .home
                    
                    //animating view
                    withAnimation{
                        self.isShow.toggle()
                    }
                }){
                    HStack(spacing: 25){
                        Image(systemName: "house")
                            .foregroundColor(self.pageSelector == .home ? Color("button") : .white)
                        
                        Text("Home")
                            .foregroundColor(self.pageSelector == .home ? Color("button") : .white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.pageSelector == .home ? Color("button").opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                }
                .padding(.top, 25)
                
//                Button(action: {
//                    self.pageSelector = .schedule
//                    //animating view
//                    withAnimation{
//                        self.isShow.toggle()
//                    }
//                }){
//                    HStack(spacing: 25){
//                        Image(systemName: "timer")
//                            .foregroundColor(self.pageSelector == .schedule ? Color("button") : .white)
//
//                        Text("Schedule Job")
//                            .foregroundColor(self.pageSelector == .schedule ? Color("button") : .white)
//                    }
//                    .padding(.vertical, 10)
//                    .padding(.horizontal)
//                    .background(self.pageSelector == .schedule ? Color("button").opacity(0.2) : Color.clear)
//                    .cornerRadius(10)
//                }
                
                Button(action: {
                    self.pageSelector = .scheduleLockBox
                    //animating view
                    withAnimation{
                        self.isShow.toggle()
                    }
                }){
                    HStack(spacing: 25){
                        Image(systemName: "timer")
                            .foregroundColor(self.pageSelector == .scheduleLockBox ? Color("button") : .white)
                        
                        Text("Schedule Air Duct Cleaning")
                            .foregroundColor(self.pageSelector == .scheduleLockBox ? Color("button") : .white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.pageSelector == .scheduleLockBox ? Color("button").opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                }
                
//                Button(action: {
//                    self.pageSelector = .scheduleCallOwner
//                    //animating view
//                    withAnimation{
//                        self.isShow.toggle()
//                    }
//                }){
//                    HStack(spacing: 25){
//                        Image(systemName: "timer")
//                            .foregroundColor(self.pageSelector == .scheduleCallOwner ? Color("button") : .white)
//
//                        Text("Schedule Call to Owner")
//                            .foregroundColor(self.pageSelector == .scheduleCallOwner ? Color("button") : .white)
//                    }
//                    .padding(.vertical, 10)
//                    .padding(.horizontal)
//                    .background(self.pageSelector == .scheduleCallOwner ? Color("button").opacity(0.2) : Color.clear)
//                    .cornerRadius(10)
//                }
                
                Button(action: {
                    self.pageSelector = .estimate
                    //animating view
                    withAnimation{
                        self.isShow.toggle()
                    }
                }){
                    HStack(spacing: 25){
                        Image(systemName: "creditcard")
                            .foregroundColor(self.pageSelector == .estimate ? Color("button") : .white)
                        
                        Text("Schedule Insulation Job")
                            .foregroundColor(self.pageSelector == .estimate ? Color("button") : .white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.pageSelector == .estimate ? Color("button").opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                }
                
                Divider()
                    .frame(width: 100, height: 1)
                    .background(Color.white)
                    .padding(.vertical, 30)
                
                Button(action: {
                    self.pageSelector = .home
                    //animating view
                    withAnimation{
                        self.isShow.toggle()
                    }
                }){
                    HStack(spacing: 25){
                        Image(systemName: "arrow.down.square")
                            .foregroundColor(.white)
                        
                        Text("Signout")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top, 25)
            .padding(.horizontal, 20)
            
            Spacer(minLength: 0)
            
        }.onTapGesture {
            self.isShow.toggle()
        }
    }
}

