//
//  AnthroForm.swift
//  RADc
//
//  Created by Frank Maranje on 7/15/23 for STI-TEC, INC.
//

import SwiftUI

struct AnthroForm: View {
    
    //MARK: properties
    @Binding var fontSize: Double
    @Binding var formStarted: Bool
    @Binding var units: Bool
    @Binding var labels: [String]
    @Binding var labelsStanding: [String]
    @Binding var labelsSitting: [String]
    @Binding var participants: [Participant]
    @Binding var newForm: Bool
    @Binding var formLoaded: Bool
    @Binding var measurements: [Bool]
    @State var loadedParticipant: Bool = false
    @State var idNumber: Int = 1
    @State var currentParticipant: Participant = Participant(labels: [], labelsStanding: [], labelsSitting: [], pNum: 0) //load blank participant placeholder

    //MARK: anthro page body
    var body: some View {
        HStack{
            
            //submitted participants list
            VStack{
                //title
                Section(header: Text("Participants").fontWeight(.thin).padding(.top)){
                    
                    Divider().frame(width: 170)
                    //new entry button
                    Button("+ New Entry"){
                        currentParticipant = Participant(labels: labels, labelsStanding: labelsStanding, labelsSitting: labelsSitting, pNum: idNumber)
                        participants.append(currentParticipant)
                        idNumber += 1
                        loadedParticipant = true
                    }.padding().background(!newForm ? .blue : .gray).foregroundColor(.white).cornerRadius(10).disabled(newForm)
                    
                    Divider().frame(width: 170)
                    //actual list
                    List(participants){ participant in
                        
                        Button("ID: \(participant.properties["Participant ID"] ?? "")\n\(participant.properties["Name"] ?? "")"){
                            currentParticipant = participants[participant.pNum - 1] //load selected participant from list
                            loadedParticipant = true
                        }
                        
                    }.frame(width:200).cornerRadius(10)
                }.padding([.leading, .bottom, .trailing])
            }.background(Color(red: 0.949, green: 0.949, blue: 0.971)).cornerRadius(10)
            
            Spacer()
            
            //Form side
            VStack{
                if formLoaded{
                    //load form (10 bindings)
                    Form(participants: $participants,
                         currentParticipant: $currentParticipant,
                         measurements: $measurements,
                         newForm: $newForm,
                         labels: $labels,
                         labelsStanding: $labelsStanding,
                         labelsSitting: $labelsSitting,
                         fontSize: $fontSize,
                         loadedParticipant: $loadedParticipant,
                         idNumber: $idNumber,
                         units: $units
                    ).transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
                }
                else{
                    //show new form button, allow user to load the new form
                    Button("+ New Form"){
                        idNumber = 1
                        withAnimation{
                            formLoaded = true
                        }
                    }.font(.system(size: fontSize * 1.5))
                }
            }
            .cornerRadius(10)
            .padding(.horizontal, 30.0)
            
            
            Spacer()
        }
        .padding()
        .font(.system(size: fontSize))
        .navigationTitle("Anthropometry Form")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {formStarted = true})
    }
    
}
