//
//  Participant.swift
//  RADc
//
//  Created by Frank Maranje on 7/16/23 for STI-TEC, INC.
//

import SwiftUI

//struct for creating participant "objects"
struct Participant: Identifiable{
    
    //MARK: properties
    var id: UUID
    var pNum: Int
    var properties: [String: String]
    
    //MARK: initializer
    init(labels: [String], labelsStanding: [String], labelsSitting: [String], pNum: Int){
        
        // Generate a unique identifier
        self.id = UUID()
        //initialize ID number
        self.pNum = pNum
        
        //procedurally generate participant "properties" according to the form configuraton
        var props: [String: String] = [:]
        for name in labels{
            props[name] = ""
        }
        for name in labelsStanding{
            props[name] = ""
        }
        for name in labelsSitting{
            props[name] = ""
        }
        
        //set properties
        properties = props
        
        //auto assign the ID number
        self.properties["Participant ID"] = String(pNum)
    }
}
