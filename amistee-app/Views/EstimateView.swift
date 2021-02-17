//
//  EstimateView.swift
//  amistee-app
//
//  Created by Apple on 13/02/21.
//

import SwiftUI

struct EstimateView: View {
    @State var pushActive = false
    @ObservedObject private var viewModel: EstimateViewModel
    let dateFormatter: DateFormatter = {
           let df = DateFormatter()
           df.dateStyle = .medium
           return df
       }()
    //add 4 days to current date
    let dateSelection = Date().addingTimeInterval(345600)
    init(state: AppState) {
        self.viewModel = EstimateViewModel(state: state)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIConfiguration.tintColor
        UISegmentedControl.appearance().backgroundColor = UIConfiguration.hoverColor

        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
    }
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                
                    NavigationLink(destination: HomeView(state: viewModel.state),
                                   isActive: self.$pushActive) {
                        EmptyView()
                    }.hidden()
                
            if viewModel.loading {
                GeometryReader { geometry in
                    ZStack(alignment: .center) {
                        Loader()
                    }
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                }
            } else {
                ScrollView() {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("Please note Amistee will have to do a free estimate at the job site in order to provide an accurate quote.")
                            .foregroundColor(.white)
                        VStack{
                            CustomTextField(placeHolderText: "Contractor Name",
                                            text: $viewModel.contractorName).disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            CustomTextField(placeHolderText: "Contact Phone Number",
                                            text: $viewModel.phoneNumber).disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            CustomTextField(placeHolderText: "Email",
                                            text: $viewModel.email)
                                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            CustomTextField(placeHolderText: "Service Address",
                                            text: $viewModel.serviceAddress)
                            CustomTextField(placeHolderText: "City",
                                            text: $viewModel.city)
                            CustomTextField(placeHolderText: "State",
                                            text: $viewModel.addressState)
                            CustomTextField(placeHolderText: "Zip",
                                            text: $viewModel.zip)
                        }
                        
                        
                        HStack{
                            RadioButtonField(
                                id: "Removal Only",
                                label: "Removal Only",
                                color:.white,
                                isMarked: $viewModel.insulationType.wrappedValue == "Removal Only" ? true : false,
                                callback: { selected in
                                    self.viewModel.insulationType = selected
                                    print("Selected insulationType is: \(selected)")
                                }
                            )
                            RadioButtonField(
                                id: "Installation Only",
                                label: "Installation Only",
                                color:.white,
                                isMarked: $viewModel.insulationType.wrappedValue == "Installation Only" ? true : false,
                                callback: { selected in
                                    self.viewModel.insulationType = selected
                                    print("Selected insulationType is: \(selected)")
                                }
                            )
                            RadioButtonField(
                                id: "Removal & Installation",
                                label: "Removal & Installation",
                                color:.white,
                                isMarked: $viewModel.insulationType.wrappedValue == "Removal & Installation" ? true : false,
                                callback: { selected in
                                    self.viewModel.insulationType = selected
                                    print("Selected insulationType is: \(selected)")
                                }
                            )
                        }
                        
                        VStack(alignment: .leading){
                            Text("Area to Estimate")
                                .foregroundColor(.white)
                                .padding(.bottom, 5)
                                .fixedSize(horizontal: false, vertical: true)
                            HStack{
                                RadioButtonField(
                                    id: "Whole House",
                                    label: "Whole House",
                                    color:.white,
                                    isMarked: $viewModel.areaToEstimate.wrappedValue == "Whole House" ? true : false,
                                    callback: { selected in
                                        self.viewModel.areaToEstimate = selected
                                        print("Selected areaToEstimate is: \(selected)")
                                    }
                                )
                                RadioButtonField(
                                    id: "Attic",
                                    label: "Attic",
                                    color:.white,
                                    isMarked: $viewModel.areaToEstimate.wrappedValue == "Attic" ? true : false,
                                    callback: { selected in
                                        self.viewModel.areaToEstimate = selected
                                        print("Selected areaToEstimate is: \(selected)")
                                    }
                                )
                            }
                            .padding(.bottom, 5)
                        }
                        VStack(alignment: .leading){
                            Text("How do we enter the property?")
                                .foregroundColor(.white)
                                .padding(.bottom, 5)
                            HStack{
                                RadioButtonField(
                                    id: "Lockbox",
                                    label: "Lockbox",
                                    color:.white,
                                    isMarked: $viewModel.entryType.wrappedValue == "Lockbox" ? true : false,
                                    callback: { selected in
                                        self.viewModel.entryType = selected
                                        print("Selected entryType is: \(selected)")
                                    }
                                )
                                RadioButtonField(
                                    id: "Call Owner",
                                    label: "Call Owner",
                                    color:.white,
                                    isMarked: $viewModel.entryType.wrappedValue == "Call Owner" ? true : false,
                                    callback: { selected in
                                        self.viewModel.entryType = selected
                                        print("Selected entryType is: \(selected)")
                                    }
                                )
                            }
                        }
                        
                        if $viewModel.entryType.wrappedValue == "Lockbox" {
                            VStack{
                                CustomTextField(placeHolderText: "Lock Box Code",
                                text: $viewModel.lockBoxCode)
                            }
                        }else if $viewModel.entryType.wrappedValue == "Call Owner" {
                            VStack{
                                CustomTextField(placeHolderText: "Home Owner's Name",
                                text: $viewModel.homeOwnerName)
                                CustomTextField(placeHolderText: "Home Owner's Telephone Nnumber",
                                text: $viewModel.homeOwnerContact)
                            }
                        }
                        VStack(alignment: .leading){
                            Text("Is a ladder greater than 6 ft. needed to access the space?")
                                .foregroundColor(.white)
                            HStack{
                                RadioButtonField(
                                    id: "Yes",
                                    label: "Yes",
                                    color:.white,
                                    isMarked: $viewModel.isLadderGreater.wrappedValue == "Yes" ? true : false,
                                    callback: { selected in
                                        self.viewModel.isLadderGreater = selected
                                    }
                                )
                                RadioButtonField(
                                    id: "No",
                                    label: "No",
                                    color:.white,
                                    isMarked: $viewModel.isLadderGreater.wrappedValue == "No" ? true : false,
                                    callback: { selected in
                                        self.viewModel.isLadderGreater = selected
                                    }
                                )
                            }
                        }
                        
                        DatePicker("Ideal Completion Date", selection: $viewModel.completionDate, in: dateSelection..., displayedComponents: .date)
                            .accentColor(Color("button"))
                            .foregroundColor(.white)
                        VStack(alignment: .leading){
                            Text("Please add any additional comments below.")
                                .foregroundColor(.white)
                            CustomTextField(placeHolderText: "Message",
                                    text: $viewModel.message)
                        }
                    
                    }
                    .padding(10)
                    VStack(alignment: .center, spacing: 40) {
                        customButton(title: "SUBMIT",
                                     backgroundColor: UIConfiguration.tintColor,
                                     action: self.viewModel.scheduleInsulationJob)
                    }.padding(20)
                }
            }
            }.alert(item: self.$viewModel.statusViewModel) { status in
                Alert(title: Text(status.title),
                      message: Text(status.message),
                      dismissButton: .default(Text("OK"), action: {
                            if status.title == "Successful" {
                                self.pushActive = true
                            }
                      }))
            }
            Spacer()
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
                                         height: 45))
        }
    }
}


struct EstimateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Color("primary").edgesIgnoringSafeArea(.all)
                EstimateView(state: AppState())
            }
        }
    }
}
