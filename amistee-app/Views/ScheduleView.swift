//
//  ScheduleView.swift
//  amistee_partner
//
//  Created by Apple on 20/12/20.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject private var viewModel: ScheduleViewModel
    
    init(state: AppState) {
        self.viewModel = ScheduleViewModel(authAPI: AuthService(), state: state)
    }
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 30) {
                ScrollView() {
                    VStack(alignment: .leading, spacing: 25) {
                        VStack{
                            CustomTextField(placeHolderText: "Contractor Name",
                                            text: $viewModel.contractorName)
                            CustomTextField(placeHolderText: "Service Address",
                                            text: $viewModel.serviceAddress)
                            CustomTextField(placeHolderText: "City",
                                            text: $viewModel.city)
                            CustomTextField(placeHolderText: "Sate",
                                            text: $viewModel.addressState)
                            CustomTextField(placeHolderText: "Zip",
                                            text: $viewModel.zip)
                            CustomTextField(placeHolderText: "Contact Phone Number",
                                            text: $viewModel.phoneNumber)
                            CustomTextField(placeHolderText: "Email",
                                            text: $viewModel.email)
                        }
                        
                        HStack{
                            Text("Type of loss")
                            HStack{
                                RadioButtonField(
                                    id: "Fire",
                                    label: "Fire",
                                    color:.white,
                                    isMarked: $viewModel.lossType.wrappedValue == "Fire" ? true : false,
                                    callback: { selected in
                                        self.viewModel.lossType = selected
                                        print("Selected lossType is: \(selected)")
                                    }
                                )
                                RadioButtonField(
                                    id: "Water",
                                    label: "Water",
                                    color:.white,
                                    isMarked: $viewModel.lossType.wrappedValue == "Water" ? true : false,
                                    callback: { selected in
                                        self.viewModel.lossType = selected
                                        print("Selected lossType is: \(selected)")
                                    }
                                )
                                RadioButtonField(
                                    id: "Other",
                                    label: "Other",
                                    color:.white,
                                    isMarked: $viewModel.lossType.wrappedValue == "Other" ? true : false,
                                    callback: { selected in
                                        self.viewModel.lossType = selected
                                        print("Selected lossType is: \(selected)")
                                    }
                                )
                            }
                        }
                        
                        VStack(alignment: .leading){
                            Text("How do we enter the property?")
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
                        VStack{
                            CustomTextField(placeHolderText: "Lock Box Code",
                                            text: $viewModel.lockBoxCode)
                            HStack{
                                Text("Selecr Furnace Size")
                                Picker("Selecr Furnace Size", selection: $viewModel.furnaceSize) {
                                    Text("1").tag("1")
                                    Text("2").tag("2")
                                    Text("3+").tag("3+")
                                }.pickerStyle(SegmentedPickerStyle())
//                                .background(Color.gray)
//                                .cornerRadius(3.0)
                                
                            }
                            HStack{
                                Text("Select no of Furnace")
                                Picker("Select no of Furnace", selection: $viewModel.numberOfFurnace) {
                                    Text("1").tag("1")
                                    Text("2").tag("2")
                                    Text("3+").tag("3+")
                                }.pickerStyle(SegmentedPickerStyle())
//                                .background(Color.gray)
//                                .cornerRadius(3.0)
                            }
                            
                            DatePicker("Select Date & Time", selection: $viewModel.serviceDate, displayedComponents: .date)
                            
                        }
                        VStack{
                            HStack{
                                Text("Add dryer Vent Cleaning?")
                                Text("*Excludes Rooftop Dryer Vent").font(Font.system(size: 14))
                            }
                            HStack{
                                RadioButtonField(
                                    id: "Yes",
                                    label: "Yes",
                                    color:.white,
                                    isMarked: $viewModel.anyDryerVent.wrappedValue == "Yes" ? true : false,
                                    callback: { selected in
                                        self.viewModel.anyDryerVent = selected
                                        print("Selected entryType is: \(selected)")
                                    }
                                )
                                RadioButtonField(
                                    id: "No",
                                    label: "No",
                                    color:.white,
                                    isMarked: $viewModel.anyDryerVent.wrappedValue == "No" ? true : false,
                                    callback: { selected in
                                        self.viewModel.anyDryerVent = selected
                                        print("Selected entryType is: \(selected)")
                                    }
                                )
                            }
                        }
                        
                        VStack(alignment: .leading){
                            Text("Is there a PO or job number you would like to associated with this job?")
                            HStack{
                                RadioButtonField(
                                    id: "Yes",
                                    label: "Yes",
                                    color:.white,
                                    isMarked: $viewModel.associatePO.wrappedValue == "Yes" ? true : false,
                                    callback: { selected in
                                        self.viewModel.associatePO = selected
                                        print("Selected associatePO is: \(selected)")
                                    }
                                )
                                RadioButtonField(
                                    id: "No",
                                    label: "No",
                                    color:.white,
                                    isMarked: $viewModel.associatePO.wrappedValue == "No" ? true : false,
                                    callback: { selected in
                                        self.viewModel.associatePO = selected
                                        print("Selected associatePO is: \(selected)")
                                    }
                                )
                            }
                            CustomTextField(placeHolderText: "Enter PO or Job Number",
                                            text: $viewModel.PONumber)
                        }
                        VStack{
                                Text("Would you like us to reach out to the home owner to let them know this job has been scheduled?")
                            HStack{
                                RadioButtonField(
                                    id: "Yes",
                                    label: "Yes",
                                    color:.white,
                                    isMarked: $viewModel.reachToOwner.wrappedValue == "Yes" ? true : false,
                                    callback: { selected in
                                        self.viewModel.reachToOwner = selected
                                        print("Selected reachToOwner is: \(selected)")
                                    }
                                )
                                RadioButtonField(
                                    id: "No",
                                    label: "No",
                                    color:.white,
                                    isMarked: $viewModel.reachToOwner.wrappedValue == "No" ? true : false,
                                    callback: { selected in
                                        self.viewModel.reachToOwner = selected
                                        print("Selected reachToOwner is: \(selected)")
                                    }
                                )
                            }
                            
                        }
                        
                        VStack(alignment: .center) {
                            Text("Air Duct Cleaning Quote: $")
                                .foregroundColor(.white)
                                .font(.headline)
                        }.padding(20)
                    }
                    .padding(10)
                    
                    VStack(alignment: .center, spacing: 40) {
                        customButton(title: "SUBMIT",
                                     backgroundColor: UIConfiguration.tintColor,
                                     action: self.viewModel.scheduleJob)
                    }.padding(20)
                }
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

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            ScheduleView(state: AppState())
        }
    }
}
