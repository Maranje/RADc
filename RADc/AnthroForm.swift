//
//  AnthroForm.swift
//  RADc
//
//  Created by Frank Maranje on 7/15/23 for STI-TEC, INC.
//

import SwiftUI

struct AnthroForm: View {
    
    @Binding var document: DocumentHandler
    
    //MARK: properties
    @State var units: Bool = true
    @State var newForm: Bool = true
    @State var formLoaded: Bool = false
    @State var loadedParticipant: Bool = false
    @State var exported: Bool = false
    @State var newFormBounce: Bool = false
    @State var newEntryBounce: Bool = false
    @State var dynamicReassign: Bool = false
    @State var autoSave: Bool = true
    @State var reorder: Bool = true
    @State var fontSize: Double = 14.0
    @State var idNumber: Int = 1
    @State var participantOffset: Int = 0
    @State var labels: [String] = ["Participant ID"]
    @State var labelsStanding: [String] = []
    @State var labelsSitting: [String] = []
    @State var measurements: [Bool] = Array(repeating: true, count: 52)
    @State var participants: [Participant] = []
    @State var currentParticipant: Participant = Participant(labels: [], labelsStanding: [], labelsSitting: [], participantOffset: 0, pNum: 0)
    @Environment(\.colorScheme) var colorScheme
    
    //MARK: anthro page body
    var body: some View {
        NavigationSplitView{
            
            //options bar title
            Text("Options").fontWeight(.thin).padding()
            
            
            //"save" button and table name entry field
            if !participants.isEmpty{
                ManualSave(document: $document,
                           labels: $labels,
                           labelsStanding: $labelsStanding,
                           labelsSitting: $labelsSitting,
                           participants: $participants,
                           exported: $exported,
                           autoSave: $autoSave,
                           units: $units
                )
            }
            
            ScrollView{
                
                Divider().padding().frame(width: 100)
                
                VStack{
                    
                    //auto save option selector (default on)
                    AutoSave(autoSave: $autoSave)
                    
                    //select between metric or imperial (default metric)
                    UnitsSelector(units: $units)
                    
                    //slider to choose form font size (default 12pt)
                    FontSizeSlider(fontSize: $fontSize)
                    
                    //toggle option to reorganize data entry fields
                    Reorganizer(reorder: $reorder)
                    
                    //dynamic participant ID toggle (default off)
                    DynamicID(dynamicReassign: $dynamicReassign, newForm: $newForm)
                    
                }
                Spacer()
                
                //"form reset" button
                if !newForm{
                    FormReset(
                        document: $document,
                        units: $units,
                        newForm: $newForm,
                        formLoaded: $formLoaded,
                        labels: $labels,
                        labelsStanding: $labelsStanding,
                        labelsSitting: $labelsSitting,
                        participants: $participants,
                        measurements: $measurements,
                        idNumber: $idNumber,
                        participantOffset: $participantOffset,
                        autoSave: $autoSave
                    )
                    .padding(.top, 5)
                }
            }
            Divider().padding()
            
            //company name subtext
            Text("© 2023 STI-TEC, INC").fontWeight(.thin).padding()
            
        } detail:{
            ZStack{
                HStack{
                    
                    //MARK: submitted participants list
                    VStack{
                        
                        //title
                        Section(header: Text("Participants").fontWeight(.thin).padding(.top)){
                            
                            Divider().frame(width: 170)
                            
                            //new entry button
                            Button("+ New Entry"){
                                currentParticipant = Participant(labels: labels, labelsStanding: labelsStanding, labelsSitting: labelsSitting, participantOffset: participantOffset, pNum: idNumber)
                                participants.append(currentParticipant)
                                idNumber += 1
                                loadedParticipant = true
                                //MARK: auto save point
                                if autoSave{
                                    //use save manager to save form contents
                                    SaveManager(document: $document,
                                                labels: $labels,
                                                labelsStanding: $labelsStanding,
                                                labelsSitting: $labelsSitting,
                                                participants: $participants,
                                                units: $units
                                    ).export()
                                }
                            }
                            .padding()
                            .background(!newForm ? .blue : .gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .disabled(newForm)
                            .scaleEffect(newEntryBounce ? 1.4 : 1.0)
                            .shadow(radius: (newEntryBounce ? 10 : 0))
                            .onChange(of: newForm, perform: {change in
                                if !change{
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        withAnimation{ newEntryBounce = true }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                        withAnimation{ newEntryBounce = false }
                                    }
                                }
                            })
                            
                            Divider().frame(width: 170)
                            
                            //actual list
                            List(participants){ participant in
                                
                                //each list item is a button that allows the user to instantly load any participant in the list
                                Button("ID: \(participant.properties["Participant ID"] ?? "")\n\(participant.properties["Name"] ?? "")"){
                                    currentParticipant = participants[participant.pNum - 1] //load selected participant from list
                                    loadedParticipant = true
                                }.fontWeight(currentParticipant.pNum == participant.pNum ? .bold : .light)
                            }
                            .frame(width:200)
                            .cornerRadius(10)
                        }
                        .padding([.leading, .bottom, .trailing])
                    }
                    .background(colorScheme == .light ? Color(red: 0.949, green: 0.949, blue: 0.971) : Color(red: 0.1, green: 0.1, blue: 0.1))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    
                    Spacer()
                    
                    //Form side
                    VStack{
                        if formLoaded{
                            //load form
                            Form(document: $document,
                                 participants: $participants,
                                 currentParticipant: $currentParticipant,
                                 measurements: $measurements,
                                 newForm: $newForm,
                                 labels: $labels,
                                 labelsStanding: $labelsStanding,
                                 labelsSitting: $labelsSitting,
                                 fontSize: $fontSize,
                                 loadedParticipant: $loadedParticipant,
                                 idNumber: $idNumber,
                                 units: $units,
                                 dynamicReassign: $dynamicReassign,
                                 participantOffset: $participantOffset,
                                 autoSave: $autoSave,
                                 reorder: $reorder
                            ).transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
                        }
                        else{
                            //show new form button, allow user to load the new form
                            Button("+ New Form"){
                                withAnimation{
                                    formLoaded = true
                                }
                            }
                            .frame(width: 200, height: 100)
                            .font(.system(size: fontSize * 1.5))
                            .scaleEffect(newFormBounce ? 1.5 : 1.0)
                            .onAppear(){
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                    withAnimation{ newFormBounce = true }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    withAnimation{ newFormBounce = false }
                                }
                            }
                        }
                    }
                    .cornerRadius(10)
                    .padding(.horizontal, 30.0)
                    
                    Spacer()
                    
                }
                .padding()
                .font(.system(size: fontSize))
                .navigationTitle(document.fileName.contains("Untitled") ? "Untitled Anthropometry Form" : "\(document.fileName)")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                
                
                if exported{
                    //fading in/out export table visual feedback text & format
                    Text("FILE SAVED")
                        .font(.body)
                        .fontWeight(.heavy)
                        .padding(.horizontal, 15.0)
                        .padding(.vertical, 50.0)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.5, opacity: 0.85))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .frame(width: 300.0, height: 300.0)
                        .zIndex(100)
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline) //removes the document name from the display
        .navigationBarBackButtonHidden(true) // removes the extraneous back button from the display
        .onAppear(){
            if !document.text.isEmpty{
                //load form contenst if DocumentHandler "text" property is not empty
                loadForm()

            }
        }
    }
    
    //MARK: methods
    func loadLabels(loadedData: [[String]]){//load labels into their corresponding string arrays
        //load through all loaded labels
        loadedData[0].enumerated().forEach{index, labelRaw in
            //reformat strings
            let label = labelRaw.replacingOccurrences(of: "\"", with: "")
            //append each label to its proper array
            if Labels().checkLabels(label: label) == true{
                labels.append(label)
            }
            else if Labels().checkLabelsStanding(label: label) == true{
                labelsStanding.append(label)
            }
            else if Labels().checkLabelsSitting(label: label) == true{
                labelsSitting.append(label)
            }
        }
        
        //remove unit classifiers from each measurement label after export
        labelsStanding.enumerated().forEach{index, label in
            if let rangeToRemove = labelsStanding[index].range(of: " [cm]"){
                labelsStanding[index].removeSubrange(rangeToRemove)
                
                //load unit type
                units = true
                
            }
            if let rangeToRemove = labelsStanding[index].range(of: " [inches]"){
                labelsStanding[index].removeSubrange(rangeToRemove)
                
                //load unit type
                units = false
                
            }
        }
        labelsSitting.enumerated().forEach{index, label in
            if let rangeToRemove = labelsSitting[index].range(of: " [cm]"){
                labelsSitting[index].removeSubrange(rangeToRemove)
            }
            if let rangeToRemove = labelsSitting[index].range(of: " [inches]"){
                labelsSitting[index].removeSubrange(rangeToRemove)
            }
        }
    }
    
    func loadParticipants(loadedData: [[String]]){//create list of participants and set their properties with the loaded values
        var participantNum: Int = 1
        
        //generate blank participants
        while participantNum < idNumber{
            participants.append(Participant(labels: labels, labelsStanding: labelsStanding, labelsSitting: labelsSitting, participantOffset: participantOffset, pNum: participantNum))
            participantNum += 1
        }
        
        //make an array from formatted, loaded, and allocated labels
        let cleanLabels: [String] = labels + labelsStanding + labelsSitting + ["Comments"]
        
        //load data into participant properties
        participants.enumerated().forEach{pIndex, participant in
            loadedData[participant.pNum].enumerated().forEach{dIndex, data in
                participants[pIndex].properties[cleanLabels[dIndex].replacingOccurrences(of: "\"", with: "")] = data.replacingOccurrences(of: "\"", with: "")
            }
        }
    }
    
    func loadForm(){//reset some values of AnthroForm properties and load data from saved document
        
        //a 2D array generated from a .csv format
        let loadedData = CSVManager().revertFromCSV(loadString: document.text)
        
        //relevant AnthroForm properties
        newForm = false
        formLoaded = true
        idNumber = loadedData.count

        //load document labels
        loadLabels(loadedData: loadedData)
        //load document participants
        loadParticipants(loadedData: loadedData)
    }
}

struct AnthroForm_Previews: PreviewProvider {
    static var previews: some View {
        AnthroForm(document: .constant(DocumentHandler()))
    }
}
