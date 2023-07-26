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
    @State var tableName: String//tableName is useless BUT FOR SOME REASON THIS WON'T WORK WITHOUT IT
    
    //MARK: initializer
    init(data: [[String]] = [[]], tableName: String = ""){
        self.data = data
        self.tableName = tableName
    }
    
    func convertToCSV() -> String { //converts the 2D array "data" into a csv formatted string
        
        var csvString = ""
        for row in data {
            let rowString = row.map { "\"\($0)\"" }.joined(separator: ",")
            csvString.append(rowString)
            csvString.append("\n")
        }
        return csvString
    }
    
    func revertFromCSV(loadString: String) -> [[String]]{ // takes data retrieved from saved document and uses it to populate a 2D array
        //empty 2D array to populate with loaded data
        var loadData: [[String]] = []
        
        //parse loaded data into an array of rows
        let rows = loadString.components(separatedBy: .newlines)
        
        // Iterate through each row and split it into columns
        for row in rows {
            let columns = row.components(separatedBy: ",")
            loadData.append(columns)
        }
        
        // Remove the first row if it's empty
        if loadData.first?.first?.isEmpty == true{
            loadData.removeFirst()
        }
        
        // Remove the last row if it's empty
        if loadData.last?.first?.isEmpty == true{
            loadData.removeLast()
        }
        
        return loadData
    }
    
}

