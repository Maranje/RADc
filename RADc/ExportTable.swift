//
//  ExportTable.swift
//  RADc
//
//  Created by Frank Maranje on 7/21/23 for STI-TEC, INC.
//

import SwiftUI

struct ExportTable: View{
    
    //MARK: properties
    @Binding var labels: [String]
    @Binding var labelsStanding: [String]
    @Binding var labelsSitting: [String]
    @Binding var participants: [Participant]
    @State var tableBool: Bool = false
    @State var tableBounce: Bool = false
    @State var tablePlaceholderText: String = "Table name"
    @State var tableName: String = ""
    @Environment(\.colorScheme) var colorScheme
    
    //MARK: export table option body
    var body: some View{
        ZStack(alignment: .topLeading){
            
            //table name text field
            TextField(tablePlaceholderText, text: $tableName)
                .frame(width: 200.0, height: 50.0)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .scaleEffect(tableBounce ? 1.2 : 1.0)
            
            //button for exporting table
            Button("Export Table"){
                
                //prompt user to enter a table name
                if tableName.isEmpty{
                    
                    //set tableBounce to true within "withAnimation" to animate scale increase effect
                    withAnimation{ tableBounce = true }
                    
                    //run after 0.25 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        
                        //set tableBounce back to false within "withAnimation" to animate scale decrease effect
                        withAnimation{ tableBounce = false}
                        
                    }
                }
                else{
                    
                    //set table name flag to true to prompt the user to confirm table export
                    tableBool = true
                }
            }
            .alert(isPresented: $tableBool){
                //export confirmation
                Alert(
                    title: Text("Confirm Export Table"),
                    message: Text("You sure about that?"),
                    primaryButton: .default(Text("Export")) {
                        
                        //create a csv using CSVManager
                        let csv = CSVManager(data: prepExport(), tableName: tableName)
                        
                        //export the csv to device documents
                        csv.exportCSV()
                        
                        //reset tableBool to false to exit prompt
                        tableBool = false
                        
                    },
                    secondaryButton: .cancel()
                )
            }
            .alignmentGuide(.leading, computeValue: { _ in -55 })
            .alignmentGuide(.top, computeValue: { _ in 25 })
            
        }
        .padding([.top, .leading, .trailing], 20.0)
        .background(colorScheme == .light ? .white : Color(red: 0.1, green: 0.1, blue: 0.1))
        .cornerRadius(10)
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
