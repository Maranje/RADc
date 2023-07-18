//
//  DataEntryField.swift
//  RADc
//
//  Created by Frank Maranje on 7/17/23 for STI-TEC, INC.
//

import SwiftUI

struct DataEntryField: View{
    
    //MARK: properties
    @Binding var labels: [String]
    @Binding var participants: [Participant]
    @Binding var currentParticipant: Participant
    
    var body: some View{
        VStack{
            ForEach(labels, id: \.self) { label in
                //procedurally generated text entry fields
                TextField(label, text:
                    Binding(
                        get: {
                            currentParticipant.properties[label] ?? ""
                        },
                        set: {
                            newValue in
                            //save to currentParticipant to display values on form
                            currentParticipant.properties[label] = newValue
                            //actual save to participants array
                            participants[currentParticipant.pNum - 1].properties[label] = newValue
                        }
                    )
                )
            }
        }
    }
}
