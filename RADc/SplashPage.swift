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
    @State var bounce: Bool = false
    @State var tapPrompt: Bool = false
    
    //MARK: splash page body
    var body: some View {
        ZStack{
            
            if splash{
                VStack{
                    //create app splash page
                    Image("RADc")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .cornerRadius(50)
                        .onTapGesture {
                            
                            //set splash to false and load AnthroForm
                            withAnimation{ splash = false }
                            
                        }
                        .scaleEffect(bounce ? 1.1 : 1.0)
                        .onAppear {
                            // Start the bounce timer when the view appears
                            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    // Toggle the isBouncing state variable to trigger the animation
                                    bounce = true
                                    //run after 0.25 seconds
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {

                                        //set bounce back to false within "withAnimation" to animate scale decrease effect
                                        withAnimation{ bounce = false}

                                    }
                                }
                            }

                            //start the prompt timer when the view appears, only run once
                            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false){ _ in
                                withAnimation{
                                    //set tapPrompt to true and show the text
                                    tapPrompt = true
                                }
                            }
                        }
                    
                    if tapPrompt{
                        //prompt text
                        Text("Tap Logo To Begin").fontWeight(.thin).foregroundColor(.gray)
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
