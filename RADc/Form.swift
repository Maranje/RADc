//
//  Form.swift
//  RADc
//
//  Created by Frank Maranje on 7/15/23 for STI-TEC, INC.
//

import SwiftUI

struct Form: View{
    
    //MARK: properties
    @Binding var document: DocumentHandler
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
    @Binding var dynamicReassign: Bool
    @Binding var participantOffset: Int
    @Binding var autoSave: Bool
    @State private var removeBool: Bool = false
    @State private var fieldNum: Int = 1
    
    //MARK: form body
    var body: some View{
        
        if newForm{
            
            //load the form configuration view
            FormConfig(measurements: $measurements,
                       newForm: $newForm,
                       labels: $labels,
                       labelsStanding: $labelsStanding,
                       labelsSitting: $labelsSitting)
                .transition(.move(edge: .bottom)
                .combined(with: .scale)
                .combined(with: .opacity))
            
        }
        else{
            
            //allow user to initiate form by adding the first participant
            if participants.isEmpty{
                
                Text("Add a new entry to begin")
                
            }
            
            //prompt the user to add a participant to continue after having removed a prior participant from the participants array
            else if !loadedParticipant{
                
                Text("Add a participant or load an existing participant to continue")
                
            }
            
            //present the form
            else{
                ScrollView{
                    
                    //PII text fields
                    Text("Participant Information").foregroundColor(.gray)
                    ForEach(labels, id: \.self) { label in
                        HStack{
                            
                            //generate entry field number
                            if let index = labels.firstIndex(of: label){
                                Text("\(index + 1). ").fontWeight(.thin).foregroundColor(.gray)
                            }
                            
                            //generate entry field
                            DataEntryField(label: label,
                                           labelWidthMultiplier: 8,
                                           labelColor: .gray,
                                           document: $document,
                                           labels: $labels,
                                           labelsStanding: $labelsStanding,
                                           labelsSitting: $labelsSitting,
                                           participants: $participants,
                                           currentParticipant: $currentParticipant,
                                           fontSize: $fontSize,
                                           units: $units,
                                           autoSave: $autoSave
                            )
                        }
                    }
                    
                    //standing measurements text fields
                    if !labelsStanding.isEmpty{
                        Divider().padding()
                        Text("Standing Measurements").foregroundColor(.blue)
                    }
                    ForEach(labelsStanding, id: \.self) { label in
                        HStack{
                            
                            //generate entry field number
                            if let index = labelsStanding.firstIndex(of: label){
                                Text("\(index + 1 + labels.count). ").fontWeight(.thin).foregroundColor(.gray)
                            }
                            
                            //generate entry field
                            DataEntryField(label: label,
                                           labelWidthMultiplier: 18,
                                           labelColor: .blue,
                                           document: $document,
                                           labels: $labels,
                                           labelsStanding: $labelsStanding,
                                           labelsSitting: $labelsSitting,
                                           participants: $participants,
                                           currentParticipant: $currentParticipant,
                                           fontSize: $fontSize,
                                           units: $units,
                                           autoSave: $autoSave
                            )
                        }
                    }
                    
                    //sitting measurements text fields
                    if !labelsSitting.isEmpty{
                        Divider().padding()
                        Text("Sitting Measurements").foregroundColor(.green)
                    }
                    ForEach(labelsSitting, id: \.self) { label in
                        HStack{
                            
                            //generate entry field number
                            if let index = labelsSitting.firstIndex(of: label){
                                Text("\(index + 1 + labels.count + labelsStanding.count). ").fontWeight(.thin).foregroundColor(.gray)
                            }
                            
                            //generate entry field
                            DataEntryField(label: label,
                                           labelWidthMultiplier: 10,
                                           labelColor: .green,
                                           document: $document,
                                           labels: $labels,
                                           labelsStanding: $labelsStanding,
                                           labelsSitting: $labelsSitting,
                                           participants: $participants,
                                           currentParticipant: $currentParticipant,
                                           fontSize: $fontSize,
                                           units: $units,
                                           autoSave: $autoSave
                            )
                        }
                    }
                    
                    //"remove entry" button: red trash icon + user alert prompt and confirmation
                    Image(systemName: "trash")
                        .padding(.top, 30.0)
                        .foregroundColor(.red)
                        .onTapGesture {
                            removeBool = true
                        }
                        .alert(isPresented: $removeBool) {
                            Alert(title: Text("Remove Current Participant"),
                                  message: Text("You sure about that?"),
                                  primaryButton: .destructive(Text("Remove"), action: removeCurrent), //run the removeCurrent()
                                  secondaryButton: .cancel(Text("Cancel")))
                            
                        }
                    
                }.onChange(of: units){unit in
                    changeUnits()
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
                //if dynamic ID mode is on, increment the participant offset property
                if !dynamicReassign{ participantOffset += 1 }
                //set bools
                loadedParticipant = false
                removed = true
            }
            //if a participant has been removed, the loop continues and shifts
            //all subsequent participant pNum values down to fill the new vacancy
            //to prevent from accidentally trying to access out of range
            else if removed{
                participants[index - 1].pNum -= 1
                //if dynamic reassign is selected, decrement all subsequrnt participant ID
                if dynamicReassign{
                    participants[index - 1].properties["Participant ID"] = String(participants[index - 1].pNum)
                }
            }
        }
        
        //reset the remove button alert bool
        removeBool = false
    }
    
    func changeUnits(){ //toggle between metric and imperial units in measurement data entry fields
        
        //iterate through all participants in participants array
        participants.enumerated().forEach{index, participant in
            //change weight
            if !(participants[index].properties["Weight"]?.isEmpty ?? true){
                let weight = Double(participants[index].properties["Weight"]?.trimmingCharacters(in: .whitespaces) ?? "0")
                if units{ participants[index].properties["Weight"] = convertToKg(measurement: weight ?? 0) }
                else{ participants[index].properties["Weight"] = convertToLbs(measurement: weight ?? 0) }
            }
            
            //change standing measurements
            labelsStanding.forEach {label in
                if !(participants[index].properties[label]?.isEmpty ?? true){
                    let measurement = Double(participants[index].properties[label]?.trimmingCharacters(in: .whitespaces) ?? "0")
                    if units{ participants[index].properties[label] = convertToCm(measurement: measurement ?? 0) }
                    else{ participants[index].properties[label] = convertToIn(measurement: measurement ?? 0) }
                }
            }
            
            //change sitting measurements
            labelsSitting.forEach {label in
                if !(participants[index].properties[label]?.isEmpty ?? true){
                    let measurement = Double(participants[index].properties[label]?.trimmingCharacters(in: .whitespaces) ?? "0")
                    if units{ participants[index].properties[label] = convertToCm(measurement: measurement ?? 0) }
                    else{ participants[index].properties[label] = convertToIn(measurement: measurement ?? 0) }
                }
            }
            
            //update current participant on form
            if currentParticipant.pNum == participant.pNum { currentParticipant = participants[index]}
        }
    }
    
    func convertToCm(measurement: Double)->String{ //converts imperial to metric
        return String(measurement * 2.54)
    }
    
    func convertToIn(measurement: Double)->String{ //converts metric to imperial
        return String(measurement / 2.54)
    }
    
    func convertToKg(measurement: Double)->String{ //converts pounds to kilograms
        return String(measurement / 2.2046)
    }
    
    func convertToLbs(measurement: Double)->String{ //converts kilograms to pounds
        return String(measurement * 2.2046)
    }
    
}
