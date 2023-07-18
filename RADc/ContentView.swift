//
//  ContentView.swift
//  RADc
//
//  Created by Frank Maranje on 7/14/23 for STI-TEC, INC.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: properties
    @State var fontSize = 12.0
    @State private var isPulsating = false
    
    //MARK: launch page body and navigation
    var body: some View {
        
        //overall nav
        NavigationView{
            VStack{
                Spacer()
                
                //link to anthropometry form page
                NavigationLink("Anthropometry Form", destination: AnthroForm(fontSize: $fontSize)).frame(width:200, height: 50).padding(.all, 20.0).background(Color.white).cornerRadius(10)
                Spacer()
                
                //font size adjustment
                Section{
                    Divider()
                    ZStack(alignment: .topLeading){
                        //slider assigns font size from 12pt:24pt
                        Slider(value: $fontSize,
                               in: 12.0...24.0
                        ).frame(width:200, height: 50)
                        //slider label
                        Text("Form Font Size").frame(width:150, height: 20).fontWeight(.thin).alignmentGuide(.leading, computeValue: { _ in -25 }).alignmentGuide(.top, computeValue: { _ in 15 })
                        
                    }.padding([.top, .leading, .trailing], 20.0).background(Color.white).cornerRadius(10)
                }.padding(.bottom, 30.0)
                
                //company name subtext
                Text("© 2023 STI-TEC, INC").fontWeight(.thin)
                
            //app title in nav window
            }.navigationTitle("RADc")
            
            //background logo image for splash page
            Image("RADc_logo").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all).padding(350.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
