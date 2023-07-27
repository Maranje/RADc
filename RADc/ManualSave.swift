//
//  ExportTable.swift
//  RADc
//
//  Created by Frank Maranje on 7/21/23 for STI-TEC, INC.
//

import SwiftUI

struct ManualSave: View{
    
    //MARK: properties
    @Binding var document: DocumentHandler
    @Binding var labels: [String]
    @Binding var labelsStanding: [String]
    @Binding var labelsSitting: [String]
    @Binding var participants: [Participant]
    @Binding var exported: Bool
    @Binding var autoSave: Bool
    @Environment(\.colorScheme) var colorScheme
    
    //MARK: export table option body
    var body: some View{
        ZStack(alignment: .topLeading){
            //button for exporting table
            Button("Save"){
                
                //use save manager to save form contents
                SaveManager(document: $document,
                            labels: $labels,
                            labelsStanding: $labelsStanding,
                            labelsSitting: $labelsSitting,
                            participants: $participants).export()
                
                //set exported to true within "withAnimation" to animate appear
                withAnimation{ exported = true }
                
                //run after 0.25 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    //set exported back to false within "withAnimation" to animate disappear
                    withAnimation{ exported = false}
                    
                }
            }
            .frame(width: 200, height: 50)
            .disabled(autoSave)
            
        }
        .padding(.all, 20.0)
        .background(colorScheme == .light ? .white : Color(red: 0.1, green: 0.1, blue: 0.1))
        .cornerRadius(10)
    }
}
