//
//  ScheduleLockBoxView.swift
//  amistee-app
//
//  Created by Apple on 05/01/21.
//

import SwiftUI

struct ScheduleView: View {
    @State var pushActive = false
    @State var estimates = Estimate(air_duct_cleaing_quote: "$0", dryer_vent_cleaning_quote: "$0", total: "$0")
    @State var hasEstimates = false
    @ObservedObject private var viewModel: ScheduleViewModel
    let dateFormatter: DateFormatter = {
           let df = DateFormatter()
           df.dateStyle = .medium
           return df
       }()
    //add 4 days to current date
    let dateSelection = Date().addingTimeInterval(345600)
    init(state: AppState) {
        self.viewModel = ScheduleViewModel(state: state)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIConfiguration.tintColor
        UISegmentedControl.appearance().backgroundColor = UIConfiguration.hoverColor

        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
    }
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 30) {
                
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
                        HStack{
                            Text("Type of loss")
                                .foregroundColor(.white)
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
                            Text("Select Sq. Footage of Living Space")
                                .foregroundColor(.white)
                            HStack{
                                Picker("Select Sq. Footage of Living Space", selection: $viewModel.livingSpace) {
                                    Text("0-1,000").tag("0-1,000")
                                    Text("1,001-2,000").tag("1,001-2,000")
                                    Text("2,001–2,900").tag("2,001–2,900")
                                    Text("2,900+").tag("2,900+")
                                }
                                .onTapGesture {
                                    callEstimate()
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                            .padding(.bottom, 10)
                            
                            HStack{
                                Text("Select No. of Furnace")
                                    .foregroundColor(.white)
                                Picker("Select No. of Furnace", selection: $viewModel.numberOfFurnace) {
                                    Text("1").tag("1")
                                    Text("2").tag("2")
                                    Text("3").tag("3")
                                }.pickerStyle(SegmentedPickerStyle())
                                .onTapGesture {
                                    callEstimate()
                                }
                                
                            }
                            
                            DatePicker("Select Schedule Date", selection: $viewModel.serviceDate, in: dateSelection..., displayedComponents: .date)
                                .accentColor(Color("button"))
                                .foregroundColor(.white)
                            
                                Text("Select Arrival Time")
                                    .foregroundColor(.white)
                            HStack{
                                Picker("Select Arrival Time Slot", selection: $viewModel.arrivalTimeSlot) {
                                    Text("8-9 AM").tag("8-9 AM")
                                    Text("11 AM to 1 PM").tag("11 AM to 1 PM")
                                    Text("1-4 PM").tag("1-4 PM")
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                            .padding(.bottom, 10)
                        }
                        
                        
                        CheckBoxField(
                            id: "Yes",
                            label: "Emergency - Need ASAP",
                            color:.white,
                            textSize: 16,
                            isMarked: $viewModel.emergency.wrappedValue == true ? true : false,
                            callback: { selected in
                                self.viewModel.emergency.toggle()
                            }
                        )
                        
                        VStack(alignment: .leading){
                            VStack(alignment: .leading){
                                Text("Add dryer Vent Cleaning?")
                                    .foregroundColor(.white)
                                Text("*Excludes Rooftop Dryer Vent")
                                    .font(Font.system(size: 12))
                                    .italic()
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom, 5)
                            HStack{
                                RadioButtonField(
                                    id: "Yes",
                                    label: "Yes",
                                    color:.white,
                                    isMarked: $viewModel.anyDryerVent.wrappedValue == "Yes" ? true : false,
                                    callback: { selected in
                                        self.viewModel.anyDryerVent = selected
                                        callEstimate()
                                    }
                                )
                                RadioButtonField(
                                    id: "No",
                                    label: "No",
                                    color:.white,
                                    isMarked: $viewModel.anyDryerVent.wrappedValue == "No" ? true : false,
                                    callback: { selected in
                                        self.viewModel.anyDryerVent = selected
                                        callEstimate()
                                    }
                                )
                            }
                        }
                        
                        VStack(alignment: .leading){
                            Text("Is there a PO or job number you would like to associated with this job?")
                                .foregroundColor(.white)
                                .padding(.bottom, 5)
                                .fixedSize(horizontal: false, vertical: true)
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
                            .padding(.bottom, 5)
                            if $viewModel.associatePO.wrappedValue == "Yes" {
                            CustomTextField(placeHolderText: "Enter PO or Job Number",
                                            text: $viewModel.PONumber)
                            }
                        }
                        VStack{
                                Text("Would you like us to reach out to the home owner to let them know this job has been scheduled?")
                                    .foregroundColor(.white)
                                    .padding(.bottom, 5)
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
                            .padding(20)
                            
                            VStack(alignment: .leading){
                                Text("Please add any additional comments below.")
                                    .foregroundColor(.white)
                                CustomTextField(placeHolderText: "Message",
                                        text: $viewModel.message)
                            }
                        }
                        VStack(alignment: .center) {
                            
                            Text("Air Duct Cleaning Quote: \(self.estimates.total)")
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
    
    private func callEstimate(){
        print("number of Furnace \(self.viewModel.numberOfFurnace)")
        if(!self.viewModel.numberOfFurnace.isEmpty && !self.viewModel.livingSpace.isEmpty){
            var lSpace = ""
            if self.viewModel.livingSpace == "0-1,000" {
                lSpace = "1000"
            }else if self.viewModel.livingSpace == "1,001-2,000" {
                lSpace = "2000"
            }else if self.viewModel.livingSpace == "2,001–2,900" {
                lSpace = "2900"
            }else if self.viewModel.livingSpace == "2,900+" {
                lSpace = "3000"
            }

            WebService().getEstimate(zip: self.viewModel.zip,livingSpace: lSpace, numberOfFurnace: self.viewModel.numberOfFurnace, anyDryerVent: self.viewModel.anyDryerVent, phoneNumber: self.viewModel.phoneNumber) {
                self.estimates = $0
                self.viewModel.cleaningQuote = self.estimates.total
            }
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
