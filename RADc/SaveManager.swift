//
//  SaveContents.swift
//  RADc
//
//  Created by Frank Maranje on 7/27/23.
//

import SwiftUI

struct SaveManager{
    
    //MARK: properties
    @Binding var document: DocumentHandler
    @Binding var labels: [String]
    @Binding var labelsStanding: [String]
    @Binding var labelsSitting: [String]
    @Binding var participants: [Participant]
    
    //MARK: methods
    func export(){
        
        //convert data into csv format and export it as an excel file to device documents
        document.text = CSVManager(data: prepExport()).convertToCSV()
        
    }
    
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
