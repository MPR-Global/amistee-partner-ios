//
//  JobsView.swift
//  amistee_partner
//
//  Created by Apple on 25/12/20.
//

import SwiftUI

struct JobsView: View {
    
    @ObservedObject var model = TicketListViewModel()
    
    var body: some View {
        ZStack{
            if model.loading {
                
                GeometryReader { geometry in
                    ZStack(alignment: .center) {
                        Loader()
                    }
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                }
            } else {
                List {
                    ForEach(model.jobs.results, id: \.ticketId) { job in
                        
                        ZStack {
                            NavigationLink(destination: JobDetailsView(job: job)){
                                JobRow(job: job)
                            }
                            HStack {
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .listRowBackground(Color("primary"))
                }
            }
        }
        .padding(.horizontal)
    }
}

struct JobsView_Previews: PreviewProvider {
    static var previews: some View {
        JobsView()
    }
}
