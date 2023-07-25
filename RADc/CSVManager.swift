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
    init(data: [[String]], tableName: String){
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
    
}

