//
//  ExportTable.swift
//  RADc
//
//  Created by Frank Maranje on 7/21/23 for STI-TEC, INC.
//

import SwiftUI

struct Save: View{
    
    //MARK: properties
    @Binding var document: DocumentHandler
    @Binding var labels: [String]
    @Binding var labelsStanding: [String]
    @Binding var labelsSitting: [String]
    @Binding var participants: [Participant]
    @Binding var exported: Bool
    @Environment(\.colorScheme) var colorScheme
    
    //MARK: export table option body
    var body: some View{
        ZStack(alignment: .topLeading){
            //button for exporting table
            Button("Save"){
                
                //create a csv using CSVManager
                let csv = CSVManager(data: prepExport(), tableName: "")
                
                //export the csv as an excel format file to device documents
                document.text = csv.convertToCSV()
                
                //set exported to true within "withAnimation" to animate appear
                withAnimation{ exported = true }
                
                //run after 0.25 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    //set exported back to false within "withAnimation" to animate disappear
                    withAnimation{ exported = false}
                    
                }
            }
            .frame(width: 200, height: 50)
            
        }
        .padding(.all, 20.0)
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
