//
//  DataEntryField.swift
//  RADc
//
//  Created by Frank Maranje on 7/17/23 for STI-TEC, INC.
//

import SwiftUI

struct DataEntryField: View{
    
    //MARK: properties
    @State var label: String
    @Binding var participants: [Participant]
    @Binding var currentParticipant: Participant
    
    var body: some View{
        //procedurally generated text entry fields
        ZStack(alignment: .leading){
            TextField(label, text:
                Binding(
                    get: {
                        currentParticipant.properties[label] ?? ""
                    },
                    set: {
                        newValue in
                        //save to currentParticipant to display values on form
                        currentParticipant.properties[label] = newValue
                        //save to participants array
                        participants[currentParticipant.pNum - 1].properties[label] = newValue
                    }
                )
            )
        }
    }
}
