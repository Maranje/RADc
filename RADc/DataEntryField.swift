//
//  DataEntryField.swift
//  RADc
//
//  Created by Frank Maranje on 7/17/23 for STI-TEC, INC.
//

import SwiftUI

struct DataEntryField: View{
    
    //MARK: properties
    let label: String
    let labelWidthMultiplier: Double
    let labelColor: Color
    @Binding var participants: [Participant]
    @Binding var currentParticipant: Participant
    @Binding var fontSize: Double
    @State var autoCap = false
    @State var foreColor: Color = .white
    @State var setLabelColor: Color = .gray
    
    //MARK: data entry field body
    var body: some View{
        //procedurally generated text entry fields
        HStack{
            //text field for data entry
            TextField(label, text:
                Binding(
                    get: {
                        currentParticipant.properties[label] ?? ""
                    },
                    set: {newValue in
                        //save to currentParticipant to display values on form
                        currentParticipant.properties[label] = newValue
                        //save to participants array
                        participants.enumerated().forEach{index, participant in
                            if participant.pNum == currentParticipant.pNum{
                                participants[index].properties[label] = newValue
                            }
                        }
                        //participants[currentParticipant.pNum - 1].properties[label] = newValue
                    }
                )
            ).autocapitalization(autoCap ? .words : .none).disableAutocorrection(true)
            
            Spacer()
            
            //field label for after data has been entered
            if !(currentParticipant.properties[label]?.isEmpty ?? true) {
                Text(label)
                    .frame(width: fontSize * labelWidthMultiplier)
                    .font(.system(size: fontSize * 0.8))
                    .foregroundColor(foreColor)
                    .background(checkBounds() ? labelColor : .red)
                    .cornerRadius(5)
            }
        }.onAppear(perform: checkName)
    }
    
    //check if the current label is "Name" in order to set autocap on for individual word
    func checkName(){
        if label == "Name"{
            autoCap = true
        }
    }
    
    //check if user input for current label is within bounds
    func checkBounds()->Bool{
        
        //check bounds here
        
        return true
    }
}
