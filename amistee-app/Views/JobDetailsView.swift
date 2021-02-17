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
                        .foregroundColor(.white)
                    
                    Text(job.summary ?? "")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                HStack{
                    Text("Status:- ")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(Utility.getJobStatus(status: job.ticketStatus))
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                }
                HStack{
                    Text("Service Date:- ")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(job.creationDate ?? "")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .navigationBarColor(.clear)
            .navigationBarTitle(Text("Job# \(String(job.ticketId))")
                                    .foregroundColor(.white), displayMode: .inline)
        }
    }
}

struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView(job: jobsData[0])
    }
}
