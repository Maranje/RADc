//
//  ExportTable.swift
//  RADc
//
//  Created by Frank Maranje on 7/21/23.
//

import SwiftUI

struct ExportTable: View{
    
    @Binding var labels: [String]
    @Binding var labelsStanding: [String]
    @Binding var labelsSitting: [String]
    @Binding var participants: [Participant]
    @State var tableBool: Bool = false
    @State var tableBounce: Bool = false
    @State var tablePlaceholderText: String = "Table name"
    @State var tableName: String = ""
    
    var body: some View{
        ZStack(alignment: .topLeading){
            //button for exporting table
            Button("Export Table"){
                //prompt user to enter a table name
                if tableName.isEmpty{
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
