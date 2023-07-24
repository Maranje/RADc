//
//  FormReset.swift
//  RADc
//
//  Created by Frank Maranje on 7/21/23 for STI-TEC, INC.
//

import SwiftUI

struct FormReset: View{
    
    //MARK: properties
    @Binding var units: Bool
    @Binding var newForm: Bool
    @Binding var formLoaded: Bool
    @Binding var labels: [String]
    @Binding var labelsStanding: [String]
    @Binding var labelsSitting: [String]
    @Binding var participants: [Participant]
    @Binding var measurements: [Bool]
    @State var reset: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    //MARK: form reset option body
    var body: some View{
        
        ZStack(alignment: .topLeading){
            
            //button to reset all form values and prepare the AnthroForm view for a new form
            Button("Reset Form") {
                reset = true
            }
            .frame(width:200, height: 50)
            .foregroundColor(Color.red)
            .alert(isPresented: $reset){
                Alert(
                    title: Text("Reset Form"),
                    message: Text("YOU SURE ABOUT THAT?"),
                    primaryButton: .destructive(Text("Reset")){
                        
                        //reset all properties to clear the form and start over
                        units = true
                        newForm = true
                        formLoaded = false
                        labels = ["Participant ID"]
                        labelsStanding = []
                        labelsSitting = []
                        participants = []
                        measurements = Array(repeating: true, count: 49)
                        reset = false
                        
                    },
                    secondaryButton: .cancel()
                )
            }
            
        }
        .padding(.all, 20.0)
        .background(colorScheme == .light ? .white : Color(red: 0.1, green: 0.1, blue: 0.1))
        .cornerRadius(10)
    }
}
