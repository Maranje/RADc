//
//  SplashPage.swift
//  RADc
//
//  Created by Frank Maranje on 7/21/23 for STI-TEC, INC.
//

import SwiftUI

struct SplashPage: View {
    
    //MARK: properties
    @State var splash: Bool = true
    
    //MARK: splash page body
    var body: some View {
        ZStack{
            
            if splash{
                
                //create app splash page
                Image("RADc")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .cornerRadius(50)
                    .onTapGesture {
                        
                        //set splash to false and load AnthroForm
                        withAnimation{ splash = false }
                        
                    }
            }
            else{
                
                //initialize anthro form
                AnthroForm()
                
            }

        }
    }
}

struct SplashPage_Previews: PreviewProvider {
    static var previews: some View {
        SplashPage()
    }
}
