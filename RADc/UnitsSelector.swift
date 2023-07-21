//
//  UnitsSelector.swift
//  RADc
//
//  Created by Frank Maranje on 7/21/23.
//

import SwiftUI

struct UnitsSelector: View{
    
    @Binding var units: Bool
    
    var body: some View{
        ZStack(alignment: .topLeading){
            //toggle between metric and imperial units
            Picker("units", selection: $units){
                Text("Metric").tag(true)
                Text("Imperial").tag(false)
            }
            .pickerStyle(.segmented).frame(width: 200.0, height: 50.0)
            
            //picker label
            Text("Units Selector")
                .frame(width:150, height: 20)
                //.fontWeight(.thin)
                .alignmentGuide(.leading, computeValue: { _ in -25 })
                .alignmentGuide(.top, computeValue: { _ in 25 })
            
        }.padding([.top, .leading, .trailing], 20.0).background(Color.white).cornerRadius(10)
    }
}
