//
//  FontSizeSlider.swift
//  RADc
//
//  Created by Frank Maranje on 7/21/23.
//

import SwiftUI

struct FontSizeSlider: View{
    
    //MARK: properties
    @Binding var fontSize: Double
    
    //MARK: font size slider option body
    var body: some View{
        
        ZStack(alignment: .topLeading){
            
            //slider assigns font size from 12pt:20pt
            Slider(value: $fontSize,
                   in: 12.0...20.0
            ).frame(width:200, height: 50)
            
            //slider label
            Text("Form Font Size")
                .frame(width:150)
                .fontWeight(.thin)
                .alignmentGuide(.leading, computeValue: { _ in -25 })
                .alignmentGuide(.top, computeValue: { _ in 15 })
            
        }.padding([.top, .leading, .trailing], 20.0).background(Color.white).cornerRadius(10)
    }
}
