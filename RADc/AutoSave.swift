//
//  AutoSave.swift
//  RADc
//
//  Created by Frank Maranje on 7/27/23 for STI-TEC, INC.
//

import SwiftUI

struct AutoSave: View{
    
    //MARK: properties
    @Binding var autoSave: Bool
    @Environment(\.colorScheme) var colorScheme
    
    //MARK: unit selector option body
    var body: some View{
        
        ZStack(alignment: .topLeading){
            
            //toggle between metric and imperial units with a stlyed picker
            Picker("autoSave", selection: $autoSave){
                Text("off").tag(false)
                Text("on").tag(true)
            }
            .pickerStyle(.segmented).frame(width: 200.0, height: 50.0)
            
            //picker label
            Text("Auto Save")
                .frame(width:150)
                .fontWeight(.thin)
                .alignmentGuide(.leading, computeValue: { _ in -25 })
                .alignmentGuide(.top, computeValue: { _ in 25 })
            
        }
        .padding([.top, .leading, .trailing], 20.0)
        .background(colorScheme == .light ? .white : Color(red: 0.1, green: 0.1, blue: 0.1))
        .cornerRadius(10)
    }
}
