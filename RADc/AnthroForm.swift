//
//  AnthroForm.swift
//  RADc
//
//  Created by Frank Maranje on 7/15/23 for STI-TEC, INC.
//

import SwiftUI

struct AnthroForm: View {
    
    //MARK: properties
    @State var units: Bool = true
    @State var newForm: Bool = true
    @State var formLoaded: Bool = false
    @State var loadedParticipant: Bool = false
    @State var fontSize: Double = 12.0
    @State var idNumber: Int = 1
    @State var labels: [String] = ["Participant ID"]
    @State var labelsStanding: [String] = []
    @State var labelsSitting: [String] = []
    @State var measurements: [Bool] = Array(repeating: true, count: 49)
    @State var participants: [Participant] = []
    @State var currentParticipant: Participant = Participant(labels: [], labelsStanding: [], labelsSitting: [], pNum: 0)
    @Environment(\.colorScheme) var colorScheme
    
    //MARK: anthro page body
    var body: some View {
        NavigationSplitView{
            
            //options bar title
            Text("Options").fontWeight(.thin).padding()
            
            //"export table" button and table name entry field
            if !participants.isEmpty{
                ExportTable(labels: $labels, labelsStanding: $labelsStanding, labelsSitting: $labelsSitting, participants: $participants)
            }
            
            //select between metric or imperial
            UnitsSelector(units: $units)
            
            //slider to choose form font size
            FontSizeSlider(fontSize: $fontSize)
            
            Spacer()
            
            //"form reset" button
            if !newForm{
                FormReset(
                    units: $units,
                    newForm: $newForm,
                    formLoaded: $formLoaded,
                    fontSize: $fontSize,
                    labels: $labels,
                    labelsStanding: $labelsStanding,
                    labelsSitting: $labelsSitting,
                    participants: $participants,
                    measurements: $measurements
                )
            }
            
            Divider().padding()
            
            //company name subtext
            Text("© 2023 STI-TEC, INC").fontWeight(.thin).padding()
            
        } detail:{
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
                            
                            //each list item is a button that allows the user to instantly load any participant in the list
                            Button("ID: \(participant.properties["Participant ID"] ?? "")\n\(participant.properties["Name"] ?? "")"){
                                currentParticipant = participants[participant.pNum - 1] //load selected participant from list
                                loadedParticipant = true
                            }
                            
                        }.frame(width:200).cornerRadius(10)
                    }.padding([.leading, .bottom, .trailing])
                }
                .background(colorScheme == .light ? Color(red: 0.949, green: 0.949, blue: 0.971) : Color(red: 0.1, green: 0.1, blue: 0.1))
                .cornerRadius(10)
                
                Spacer()
                
                //Form side
                VStack{
                    if formLoaded{
                        //load form
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
        }
    }
}
