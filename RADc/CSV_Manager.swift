//
//  CSV_Manager.swift
//  RADc
//
//  Created by Frank Maranje on 7/15/23 for STI-TEC, INC.
//

import SwiftUI
import Foundation

struct CSVManager{
    
    //MARK: properties
    @State var data: [[String]] = [[]]
    @State var tableName: String
    
    //MARK: initializer
    init(data: [[String]], tableName: String){
        self.data = data
        self.tableName = tableName
    }
    
    //MARK: methods
    //takes the csv converted 2D array data and exports it as a .csv file
    func exportCSV(){
        
        //convert 2D array "data"
        let csvString = convertToCSV()
        //name of the exported file
        let fileName = "\(tableName).csv"

        /*
         set the file path, hopefully like... in the most convenient place.
         i used ".userDomainMask" so it just sets the path according to the
         device it's running on and ideally saves files in a super easy spot.
         can't really test it for sure until the app can run on an ipad outside
         of a container, so just hoping for the best here really.
         works well in the sim at least.
        */
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        else {
            return
        }

        //complete the file URL by appending the file name to the path
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        //save the csv file to the path
        do {
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("Exported .csv file: \(fileURL.absoluteString)")
        } catch {
            print("Error exporting .csv file: \(error)")
        }
    }
    
    //converts the 2D array "data" into a csv formatted string
    func convertToCSV() -> String {
        var csvString = ""
        for row in data {
            let rowString = row.map { "\"\($0)\"" }.joined(separator: ",")
            csvString.append(rowString)
            csvString.append("\n")
        }
        return csvString
    }
    
}

