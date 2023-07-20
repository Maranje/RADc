//
//  ContentView.swift
//  RADc
//
//  Created by Frank Maranje on 7/14/23 for STI-TEC, INC.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: properties
    @State var formStarted: Bool = false
    @State var units: Bool = true
    @State var tableBool: Bool = false
    @State var tableBounce: Bool = false
    @State var newForm: Bool = true
    @State var reset: Bool = false
    @State var formLoaded: Bool = false
    @State var fontSize: Double = 12.0
    @State var tablePlaceholderText: String = "Table name"
    @State var tableName: String = ""
    @State var labels: [String] = ["Participant ID"]
    @State var labelsStanding: [String] = []
    @State var labelsSitting: [String] = []
    @State var participants: [Participant] = []
    //@Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    //MARK: launch page body and navigation
    var body: some View {
        
        //overall nav (NavigationView has been deprecated after iOS 16, plan to switch to either NavigationStack or NavigationSplitView)
        NavigationView{
            VStack{
                
                if !formStarted{
                    Spacer()
                    
                    //link to anthropometry form page
                    NavigationLink("Anthropometry Form", destination: AnthroForm(fontSize: $fontSize,
                                                                                 formStarted: $formStarted,
                                                                                 units: $units,
                                                                                 labels: $labels,
                                                                                 labelsStanding: $labelsStanding,
                                                                                 labelsSitting: $labelsSitting,
                                                                                 participants: $participants,
                                                                                 newForm: $newForm,
                                                                                 formLoaded: $formLoaded
                                                                                )
                    ).frame(width:200, height: 50).padding(.all, 20.0).background(Color.white).cornerRadius(10)
                    
                    Spacer()
                    Divider()
                }
                
                ///I hate all these conditional layers, but as of right now i can't find anything in
                ///any apple documentation that explains how to use guard clauses that
                ///comply with View protocols so i guess this'll have to cut it in the meantime -_-
                //form options
                else{
                    
                    Section{
                        
                        Spacer()
                        
                        //MARK: export table button
                        if !participants.isEmpty{
                            ZStack(alignment: .topLeading){
                                //button for exporting table
                                Button("Export Table"){
                                    //prompt user to enter a table name
                                    if tableName.isEmpty{
                                        tablePlaceholderText = "Table Name Required"
                                        withAnimation{ tableBounce = true }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            withAnimation{ tableBounce = false}
                                        }
                                    }
                                    else{
                                        tableBool = true
                                    }
                                }
                                .alert(isPresented: $tableBool){
                                    //export confirmation
                                    Alert(
                                        title: Text("Confirm Export Table"),
                                        message: Text("You sure about that?"),
                                        primaryButton: .default(Text("Export")) {
                                            let csv = CSVManager(data: prepExport(), tableName: tableName)
                                            csv.exportCSV()
                                            tableBool = false
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                                .alignmentGuide(.leading, computeValue: { _ in -55 })
                                .alignmentGuide(.top, computeValue: { _ in 25 })
                                
                                //table name text field
                                TextField(tablePlaceholderText, text: $tableName)
                                    .frame(width: 200.0, height: 50.0)
                                    .textFieldStyle(.roundedBorder)
                                    .multilineTextAlignment(.center)
                                    .scaleEffect(tableBounce ? 1.2 : 1.0)
                                
                            }.padding([.top, .leading, .trailing], 20.0).background(Color.white).cornerRadius(10)
                        }
                        
                        //MARK: measurement units selector
                        ZStack(alignment: .topLeading){
                            //toggle between metric and imperial units
                            Picker("units", selection: $units){
                                Text("Metric").tag(true)
                                Text("Imperial").tag(false)
                            }
                            .pickerStyle(.segmented).frame(width: 200.0, height: 50.0)
                            
                            //picker label
                            Text("Units Selector")
                                .frame(width:150, height: 20)
                                //.fontWeight(.thin)
                                .alignmentGuide(.leading, computeValue: { _ in -25 })
                                .alignmentGuide(.top, computeValue: { _ in 25 })
                            
                        }.padding([.top, .leading, .trailing], 20.0).background(Color.white).cornerRadius(10)
                        
                        //MARK: font size adjustment
                        ZStack(alignment: .topLeading){
                            //slider assigns font size from 12pt:20pt
                            Slider(value: $fontSize,
                                   in: 12.0...20.0
                            ).frame(width:200, height: 50)
                            
                            //slider label
                            Text("Form Font Size")
                                .frame(width:150, height: 20)
                                //.fontWeight(.thin)
                                .alignmentGuide(.leading, computeValue: { _ in -25 })
                                .alignmentGuide(.top, computeValue: { _ in 15 })
                            
                        }.padding([.top, .leading, .trailing], 20.0).background(Color.white).cornerRadius(10)
                        
                        Spacer()
                        
                        if !newForm{
                            //MARK: reset form
                            ZStack(alignment: .topLeading){
                                Button("Reset Form") {
                                    reset = true
                                }
                                .frame(width:200, height: 50)
                                .foregroundColor(Color.red)
                                .alert(isPresented: $reset){
                                    Alert(
                                        title: Text("Reset Form"),
                                        message: Text("YOU SURE ABOUT THAT?"),
                                        primaryButton: .destructive(Text("Reset")){
                                            units = true
                                            tableBool = false
                                            tableBounce = false
                                            newForm = true
                                            formLoaded = false
                                            fontSize = 12.0
                                            tablePlaceholderText = "Table name"
                                            tableName = ""
                                            labels = ["Participant ID"]
                                            labelsStanding = []
                                            labelsSitting = []
                                            participants = []
                                            reset = false
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                                
                            }.padding(.all, 20.0).background(Color.white).cornerRadius(10)
                        }
                    }.padding(.bottom, 30.0)
                    
                    Divider()
                }
                
                //company name subtext
                Text("© 2023 STI-TEC, INC").fontWeight(.thin).padding()
                
            //app title in nav window
            }.navigationTitle("RADc")
            
            //background logo image for splash page
            ZStack{
                //Image("backdrop").resizable().opacity(fade ? 1.0 : 0.0).scaledToFill().edgesIgnoringSafeArea(.all).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding([.top, .leading], 60)
                Image("RADc").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all).padding(350.0)
            }
//            .onAppear {
//                if horizontalSizeClass == .regular{
//                    //fade in and out the backdrop to catch user's attention and guide them to the nav bar button to begin
//                    withAnimation(Animation.easeInOut(duration: 0.4).repeatCount(4, autoreverses: true)) {
//                        fade = true
//                    }
//                    //fade back out and stay invisible after the duration of the previous animation
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
//                        withAnimation(.easeInOut(duration: 0.4)) {
//                            fade = false
//                        }
//                    }
//                }
//            }
        }
    }
    
    //MARK: methods
    func prepExport()->[[String]]{//prepare a 2D array of all data for conversion to a .csv file
        
        //2D array for prep and export
        var exportData: [[String]] = [[]]
        //concatenate three label arrays into one, making all the table labels
        let allLabels: [String] = labels + labelsStanding + labelsSitting
        //append labels to first array in 2D array
        exportData.append(allLabels)
        
        //nested forEach loop that iterates through all participants in participants array
        //and then through all labels in labels array, appending each participants measurement
        //value into a temporary array to then be appended into exportData
        participants.forEach{participant in
            var tempArray: [String] = []
            allLabels.forEach{label in
                tempArray.append(participant.properties[label] ?? "")
            }
            exportData.append(tempArray)
        }
        
        return exportData
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
