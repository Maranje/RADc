//
//  SaveContents.swift
//  RADc
//
//  Created by Frank Maranje on 7/27/23 for STI-TEC, INC.
//

import SwiftUI

struct SaveManager{
    
    //MARK: properties
    @Binding var document: DocumentHandler
    @Binding var labels: [String]
    @Binding var labelsStanding: [String]
    @Binding var labelsSitting: [String]
    @Binding var participants: [Participant]
    @Binding var units: Bool
    
    //MARK: methods
    func export(){
        
        //convert data into csv format and export it as an excel file to device documents
        document.text = CSVManager(data: prepExport()).convertToCSV()
        
    }
    
    func prepExport()->[[String]]{//prepare a 2D array of all data for conversion to a .csv file
        
        //2D array for prep and export
        var exportData: [[String]] = [[]]
        
        //append unit classifiers to each measurement label
        labelsStanding.enumerated().forEach{index, label  in
            labelsStanding[index].append(units ? " [cm]" : " [inches]")
        }
        labelsSitting.enumerated().forEach{index, label  in
            labelsSitting[index].append(units ? " [cm]" : " [inches]")
        }
        
        //concatenate three label arrays into one, making all the table labels
        let allLabels: [String] = labels + labelsStanding + labelsSitting + ["Comments"]
        
        //append labels to first array in 2D array
        exportData.append(allLabels)
        
        //remove unit classifiers from each measurement label after export
        labelsStanding.enumerated().forEach{index, label in
            if let rangeToRemove = labelsStanding[index].range(of: " [cm]"){
                labelsStanding[index].removeSubrange(rangeToRemove)
            }
            if let rangeToRemove = labelsStanding[index].range(of: " [inches]"){
                labelsStanding[index].removeSubrange(rangeToRemove)
            }
        }
        labelsSitting.enumerated().forEach{index, label in
            if let rangeToRemove = labelsSitting[index].range(of: " [cm]"){
                labelsSitting[index].removeSubrange(rangeToRemove)
            }
            if let rangeToRemove = labelsSitting[index].range(of: " [inches]"){
                labelsSitting[index].removeSubrange(rangeToRemove)
            }
        }
        
        //concatenate three label arrays into one, making all the table labels
        let cleanLabels: [String] = labels + labelsStanding + labelsSitting + ["Comments"]
        
        //nested forEach loop that iterates through all participants in participants array
        //and then through all labels in labels array, appending each participants measurement
        //value into a temporary array to then be appended into exportData
        participants.forEach{participant in
            var tempArray: [String] = []
            cleanLabels.forEach{label in
                tempArray.append(participant.properties[label] ?? "")
            }
            exportData.append(tempArray)
        }
        
        return exportData
    }
}
