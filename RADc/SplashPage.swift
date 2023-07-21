//
//  SplashPage.swift
//  RADc
//
//  Created by Frank Maranje on 7/21/23.
//

import SwiftUI

struct SplashPage: View {
    
    //MARK: properties
    @State var splash: Bool = true
    
    var body: some View {
        ZStack{
            if splash{
                //create app splash page
                Image("RADc")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .cornerRadius(50)
                    .onTapGesture {
                        withAnimation{
                            splash = false
                        }
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
