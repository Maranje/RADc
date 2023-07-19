//
//  Form.swift
//  RADc
//
//  Created by Frank Maranje on 7/15/23 for STI-TEC, INC.
//

import SwiftUI

struct Form: View{
    
    //MARK: properties
    @Binding var participants: [Participant]
    @Binding var currentParticipant: Participant
    @Binding var measurements: [Bool]
    @Binding var newForm: Bool
    @Binding var labels: [String]
    @Binding var labelsStanding: [String]
    @Binding var labelsSitting: [String]
    @Binding var fontSize: Double
    @Binding var loadedParticipant: Bool
    @Binding var idNumber: Int
    @Binding var units: Bool
    @State private var removeBool: Bool = false
    
    //MARK: form body
    var body: some View{
        if newForm{
            FormConfig(measurements: $measurements, newForm: $newForm, labels: $labels, labelsStanding: $labelsStanding, labelsSitting: $labelsSitting).transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
        }
        else{
            //allow user to initiate form by adding the first participant
            if participants.isEmpty && loadedParticipant{
                Text("Add the first participant to begin").transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
            }
            //prompt the user to add a participant to continue after having removed all prior participants from the participants array
            else if participants.isEmpty && !loadedParticipant{
                Text("Add a participant to continue").transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
            }
            //prompt the user to add a participant to continue after having removed a prior participant from the participants array
            else if !loadedParticipant{
                Text("Add a participant or load an existing participant to continue").transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
            }
            //present the form
            else{
                ScrollView{
                    
                    //PII text fields
                    Text("Participant Information").foregroundColor(.gray)
                    ForEach(labels, id: \.self) { label in
                        DataEntryField(label: label, labelWidthMultiplier: 8, labelColor: .gray, participants: $participants, currentParticipant: $currentParticipant, fontSize: $fontSize)
                    }
                    
                    
                    //standing measurements text fields
                    Divider().padding()
                    Text("Standing Measurements").foregroundColor(.blue)
                    ForEach(labelsStanding, id: \.self) { label in
                        DataEntryField(label: label, labelWidthMultiplier: 18, labelColor: .blue, participants: $participants, currentParticipant: $currentParticipant, fontSize: $fontSize)
                    }
                    
                    //sitting measurements text fields
                    Divider().padding()
                    Text("Sitting Measurements").foregroundColor(.green)
                    ForEach(labelsSitting, id: \.self) { label in
                        DataEntryField(label: label, labelWidthMultiplier: 10, labelColor: .green, participants: $participants, currentParticipant: $currentParticipant, fontSize: $fontSize)
                    }
                    
                    //"remove entry" button: red trash icon + user alert prompt and confirmation
                    Image(systemName: "trash")
                        .padding(.top, 30.0)
                        .foregroundColor(.red)
                        .onTapGesture {
                            removeBool = true
                        }
                }.onChange(of: units){unit in
                    changeUnits()
                }
                .alert(isPresented: $removeBool) {
                    Alert(title: Text("Remove Current Participant"),
                          message: Text("You sure about that?"),
                          primaryButton: .destructive(Text("Remove"), action: removeCurrent), //run the removeCurrent()
                          secondaryButton: .cancel(Text("Cancel")))
                
                }
            }
        }
    }
    
    //MARK: methods
    func removeCurrent(){ //function for removing the current participant on the form by tapping the red trash icon
        
        //bool for flagging when a participant is removed during the forEach loop
        var removed: Bool = false
        
        //loop to iterate through participants array
        participants.enumerated().forEach {index, participant in
            //determine if current iteration matches the current participant on the form
            if participant.pNum == currentParticipant.pNum{
                //remove the participant at the index
                participants.remove(at: index)
                //decrement the participant generator idNumber value by one
                idNumber -= 1
                //set bools
                loadedParticipant = false
                removed = true
            }
            //if a participant has been removed, the loop continues and shifts all subsequent participants down to fill the new vacancy
            else if removed{
                participants[index - 1].pNum -= 1
                participants[index - 1].properties["Participant ID"] = String(participants[index - 1].pNum)
            }
        }
        
        //reset the remove button alert bool
        removeBool = false
    }
    
    func changeUnits(){ //toggle between metric and imperial units in measurement data entry fields
        //add code here
    }
}
