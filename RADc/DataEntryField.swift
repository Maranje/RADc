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
                        //save from currentParticipant to corresponding participant in participants array
                        participants.enumerated().forEach{index, participant in
                            if participant.pNum == currentParticipant.pNum{
                                participants[index].properties[label] = newValue
                            }
                        }
                    }
                )
            ).onAppear(perform: checkName).autocapitalization(autoCap ? .words : .none).disableAutocorrection(true)
            
            Spacer()
            
            //text field label, appears after data has been entered
            if !(currentParticipant.properties[label]?.isEmpty ?? true) {
                Text(label)
                    .frame(width: fontSize * labelWidthMultiplier)
                    .font(.system(size: fontSize * 0.8))
                    .foregroundColor(foreColor)
                    .background(checkBounds() ? labelColor : .red)
                    .cornerRadius(5)
            }
        }
    }
    
    //MARK: methods
    func checkName(){ //check if the current label is "Name" in order to set autocap on for individual word
        if label == "Name"{
            autoCap = true
        }
    }
    
    func checkBounds()->Bool{ //check if user input for current label is within bounds
        
        //check bounds here
        
        return true
    }
}
