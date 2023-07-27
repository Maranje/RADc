//
//  DynamicID.swift
//  RADc
//
//  Created by Frank Maranje on 7/26/23.
//

import SwiftUI

struct DynamicID: View{
    
    @Binding var dynamicReassign: Bool
    @Binding var newForm: Bool
    @State var popup: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        ZStack{
            ZStack(alignment: .topLeading){
                
                //toggle between metric and imperial units with a stlyed picker
                Picker("dynamic ID", selection: $dynamicReassign){
                    Text("off").tag(false)
                    Text("on").tag(true)
                }
                .pickerStyle(.segmented).frame(width: 200.0, height: 50.0)
                .disabled(!newForm)
                
                //picker label
                Text("Dynamic ID")
                    .frame(width:150)
                    .fontWeight(.thin)
                    .alignmentGuide(.leading, computeValue: { _ in -25 })
                    .alignmentGuide(.top, computeValue: { _ in 25 })
                
                //question popup image
                Image(systemName: "questionmark.circle")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        withAnimation{ popup = true }
                    }
                    .alignmentGuide(.leading, computeValue: { _ in -150 })
                    .alignmentGuide(.top, computeValue: { _ in 25 })
                
            }
            .padding([.top, .leading, .trailing], 20.0)
            .background(colorScheme == .light ? .white : Color(red: 0.1, green: 0.1, blue: 0.1))
            .cornerRadius(10)
            
            if popup{
                ZStack{
                    Button("Automatically reassign Participant ID"){
                        withAnimation{ popup = false }
                    }
                    .frame(width: 200, height: 50)
                }
                .font(.system(size: 12))
                .padding(.all, 10.0)
                .background(colorScheme == .light ? .gray : Color(red: 0.1, green: 0.1, blue: 0.1))
                .cornerRadius(10)
                .foregroundColor(.white)
                .opacity(0.75)
            }
        }
        
    }
}
