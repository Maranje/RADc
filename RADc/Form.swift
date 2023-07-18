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
    
    //MARK: form body
    var body: some View{
        if newForm{
            FormConfig(measurements: $measurements, newForm: $newForm, labels: $labels, labelsStanding: $labelsStanding, labelsSitting: $labelsSitting).transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
        }
        else{
            //allow user to initiate form by adding the first participant
            if participants.isEmpty{
                Text("Add the first participant to begin").transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
            }
            else{
                ScrollView{
                    
                    //PII text fields
                    Text("Participant Information").foregroundColor(.gray)
                    DataEntryField(labels: $labels, participants: $participants, currentParticipant: $currentParticipant)
                    
                    //standing measurements text fields
                    Divider().padding()
                    Text("Standing Measurements").foregroundColor(.blue)
                    DataEntryField(labels: $labelsStanding, participants: $participants, currentParticipant: $currentParticipant)
                    
                    //sitting measurements text fields
                    Divider().padding()
                    Text("Sitting Measurements").foregroundColor(.green)
                    DataEntryField(labels: $labelsSitting, participants: $participants, currentParticipant: $currentParticipant)
                    
                    //"remove entry" button
                    Image(systemName: "trash")
                        .padding(.top, 30.0)
                        .foregroundColor(.red)
                        .onTapGesture {
                            // Handle trash button action here
                        }
                }
            }
        }
    }
}
