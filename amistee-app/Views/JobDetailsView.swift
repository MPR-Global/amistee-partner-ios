//
//  JobDetailsView.swift
//  amistee_partner
//
//  Created by Apple on 25/12/20.
//

import SwiftUI

struct JobDetailsView: View {
    var job: Ticket
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 20) {
                HStack{
                    Text("Service Location:- ")
                        .font(.headline)
                    
                    Text(job.summary ?? "")
                        .font(.subheadline)
                }
                HStack{
                    Text("Status:- ")
                        .font(.headline)
                    
                    Text(job.ticketStatus)
                        .font(.subheadline)
                    
                }
                HStack{
                    Text("Service Date:- ")
                        .font(.headline)
                    
                    Text(job.creationDate ?? "")
                        .font(.subheadline)
                }
                Spacer()
            }
            .navigationBarTitle(Text("Job# \(job.ticketId)"))
        }
    }
}

struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView(job: jobsData[0])
    }
}
