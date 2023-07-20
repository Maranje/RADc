//
//  ContentView.swift
//  RADc
//
//  Created by Frank Maranje on 7/14/23 for STI-TEC, INC.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: properties
    @State var fontSize: Double = 12.0
    @State var formStarted: Bool = false
    @State var units: Bool = true
    @State var labels: [String] = ["Participant ID"]
    @State var labelsStanding: [String] = []
    @State var labelsSitting: [String] = []
    @State var participants: [Participant] = []
    @State var tableName: String = ""
    @State var tableBool: Bool = false
    @State var tableBounce: Bool = false
    @State var tablePlaceholderText: String = "Table name"
    @State var loadedParticipant: Bool = false
    
    //MARK: launch page body and navigation
    var body: some View {
        
        //overall nav
        NavigationView{
            VStack{
                
                Spacer()
                
                //link to anthropometry form page
                NavigationLink("Anthropometry Form", destination: AnthroForm(fontSize: $fontSize,
                                                                             formStarted: $formStarted,
                                                                             units: $units,
                                                                             labels: $labels,
                                                                             labelsStanding: $labelsStanding,
                                                                             labelsSitting: $labelsSitting,
                                                                             participants: $participants,
                                                                             loadedParticipant: $loadedParticipant
                                                                            )
                ).frame(width:200, height: 50).padding(.all, 20.0).background(Color.white).cornerRadius(10)
                
                Spacer()
                
                ///I hate all these conditional layers, but as of right now i can't find anything in
                ///any apple documentation that explains how to use guard clauses that
                ///comply with View protocols so i guess this'll have to cut it in the meantime -_-
                
                //form options
                if formStarted{
                    Section{
                        
                        Divider()
                        
                        //MARK: export table button
                        if loadedParticipant{
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
                            //slider assigns font size from 12pt:24pt
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
                    }.padding(.bottom, 30.0)
                }
                //company name subtext
                Text("© 2023 STI-TEC, INC").fontWeight(.thin)
                
            //app title in nav window
            }.navigationTitle("RADc")
            
            //background logo image for splash page
            Image("RADc").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all).padding(350.0)
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
