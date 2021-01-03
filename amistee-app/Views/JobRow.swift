//
//  JobRow.swift
//  amistee_partner
//
//  Created by Apple on 25/12/20.
//

import SwiftUI

struct JobRow: View {
    var job: Ticket
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Job#: \(job.ticketId)")
                .font(.largeTitle)
            
            Text(job.summary ?? "")
                .font(.headline)
            
            Text("Status:- \(job.ticketStatus)")
                .lineLimit(2)
                .lineSpacing(2)
                .font(.headline)
                .frame(height: 20)
            
            Text(job.creationDate ?? "")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color("button"))
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.gray)
        }
    }
}

struct JobRow_Previews: PreviewProvider {
    static var previews: some View {
        JobRow(job: jobsData[0])
    }
}
