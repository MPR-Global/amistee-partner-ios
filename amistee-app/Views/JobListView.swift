//
//  JobListView.swift
//  amistee_partner
//
//  Created by Apple on 19/12/20.
//

import SwiftUI

struct JobListView: View {
    @ObservedObject var state: AppState
    var jobs = jobsData
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
    NavigationView{
        ScrollView() {
        VStack(){
            HStack() {
                VStack(alignment: .leading) {
                  Text("Jobs")
                    .modifier(TextModifier(font: UIConfiguration.titleFont,
                                           color: UIConfiguration.tintColor))
                    .padding(.leading, 25)

                  Text("22 Tickets")
                     .foregroundColor(.gray)
               }
//               Spacer()
            }
            .padding(60.0)
                ForEach(jobs) { job in
                    
                        NavigationLink(destination: WelcomeView(state: AppState())) {
                                        EmptyView()
                        }
                        .navigationBarHidden(true)
                    
                        HStack() {
                        JobRow(job: job)
                        Image(systemName: "chevron.right")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 7)
                          .foregroundColor(Color("button"))
                        }
                }
                .padding(8.0)
        }
        .foregroundColor(Color.white)
        }
      .background(Color("primary"))
    }
    .padding(.top, -150)
    }
    }
}


#if DEBUG
struct JobListView_Previews: PreviewProvider {
   static var previews: some View {
    JobListView(state: AppState())
      .previewDevice("iPhone X")
   }
}
#endif


struct Ticket1: Identifiable  {
    var id = UUID()
    var ticketId: String
    var serviceLocation:String?
    var ticketStatus: String
    var creationDate:String?
}

let jobsData = [
    Ticket(ticketId: 12457, ticketStatus: "Open: Ready for Billing", serviceLocation: "Bob Smith, 11490 Chery st., Howell, MI", creationDate: "JUN 26"),
    Ticket(ticketId: 12467, ticketStatus: "Open: Ready for Billing", serviceLocation: "Bob Smith, 11490 Chery st., Howell, MI", creationDate: "JUN 11"),
    Ticket(ticketId: 12464, ticketStatus: "Open: Ready for Billing", serviceLocation: "Bob Smith, 11490 Chery st., Howell, MI", creationDate: "JUN 11"),
    Ticket(ticketId: 12468, ticketStatus: "Open: Ready for Billing", serviceLocation: "Bob Smith, 11490 Chery st., Howell, MI", creationDate: "JUN 11"),
]

