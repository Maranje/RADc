//
//  FormConfig.swift
//  RADc
//
//  Created by Frank Maranje on 7/16/23 for STI-TEC, INC.
//

import SwiftUI

//FormConfig allows the user to configure an array of bools determining which measurements will be used in the anthro form
struct FormConfig: View{
    
    //MARK: properties
    @Binding var measurements: [Bool]
    @Binding var newForm: Bool
    @Binding var labels: [String]
    @Binding var labelsStanding: [String]
    @Binding var labelsSitting: [String]
    @State var selectAll: Bool = true
    
    //MARK: form config body
    var body: some View{
        ScrollView{
            Section(header: Text("New Form Configuration").fontWeight(.thin)) {
                
                Divider().padding()
                
                HStack{
                    //"create form" button to create the form and load all the chosen measurement labels into the appropriate string arrays
                    Button("Create Form"){
                        
                        //apply all selected labels and create the form
                        createForm()
                        
                    }.padding().background(.green).foregroundColor(.white).cornerRadius(10)//button visibility properties
                    
                    //buttons for toggling all values selected or de-selected
                    if selectAll{
                        Button("Deselect All"){
                            measurements = Array(repeating: false, count: 49)
                            selectAll = false
                        }.padding().background(.orange).foregroundColor(.white).cornerRadius(10)//button visibility properties
                    }
                    else{
                        Button("Reselect All"){
                            measurements = Array(repeating: true, count: 49)
                            selectAll = true
                        }.padding().background(.orange).foregroundColor(.white).cornerRadius(10)//button visibility properties
                    }
                }
                
                //allow user to assign all the desired labels in the form
                VStack{
                    Toggle("Name", isOn: $measurements[1]).padding(.horizontal)
                    Toggle("Phone Number", isOn: $measurements[2]).padding(.horizontal)
                    Toggle("Email", isOn: $measurements[3]).padding(.horizontal)
                    Toggle("Age", isOn: $measurements[4]).padding(.horizontal)
                    Toggle("Aircraft", isOn: $measurements[5]).padding(.horizontal)
                    Toggle("Weight", isOn: $measurements[6]).padding(.horizontal)
                    Toggle("AFSC", isOn: $measurements[7]).padding(.horizontal)
                    Toggle("Gender", isOn: $measurements[8]).padding(.horizontal)
                    Toggle("Ethnicity", isOn: $measurements[9]).padding(.horizontal)
                    Toggle("Stature (standing)", isOn: $measurements[10]).padding(.horizontal)
                }
                VStack{
                    Toggle("Stature (sitting)", isOn: $measurements[11]).padding(.horizontal)
                    Toggle("Eye Height (standing)", isOn: $measurements[12]).padding(.horizontal)
                    Toggle("Eye Height (sitting)", isOn: $measurements[13]).padding(.horizontal)
                    Toggle("Acromial Height (standing)", isOn: $measurements[14]).padding(.horizontal)
                    Toggle("Acromial Height (sitting)", isOn: $measurements[15]).padding(.horizontal)
                    Toggle("Suprasternale Height", isOn: $measurements[16]).padding(.horizontal)
                    Toggle("Waist Height", isOn: $measurements[17]).padding(.horizontal)
                    Toggle("Waist Front Length", isOn: $measurements[18]).padding(.horizontal)
                    Toggle("Chest Circumference @ Scye", isOn: $measurements[19]).padding(.horizontal)
                    Toggle("Chest Circumference", isOn: $measurements[20]).padding(.horizontal)
                }
                VStack{
                    Toggle("Waist Circumference (omphalion)", isOn: $measurements[21]).padding(.horizontal)
                    Toggle("Waist Circumference (natural)", isOn: $measurements[22]).padding(.horizontal)
                    Toggle("Max Hip Circumference", isOn: $measurements[23]).padding(.horizontal)
                    Toggle("Thigh Circumference", isOn: $measurements[24]).padding(.horizontal)
                    Toggle("Vertical Trunk Circumference", isOn: $measurements[25]).padding(.horizontal)
                    Toggle("Kneeling Reach", isOn: $measurements[26]).padding(.horizontal)
                    Toggle("Arm Span", isOn: $measurements[27]).padding(.horizontal)
                    Toggle("Thumb Tip Reach average", isOn: $measurements[28]).padding(.horizontal)
                    Toggle("Overhead Reach (flat - shoes off)", isOn: $measurements[29]).padding(.horizontal)
                    Toggle("Overhead Reach (tiptoes - shoes off)", isOn: $measurements[30]).padding(.horizontal)
                }
                VStack{
                    Toggle("Overhead Reach (flat - shoes/uniform on)", isOn: $measurements[31]).padding(.horizontal)
                    Toggle("Overhead Reach (tiptoes - shoes/uniform on)", isOn: $measurements[32]).padding(.horizontal)
                    Toggle("Overhead Reach (sitting)", isOn: $measurements[33]).padding(.horizontal)
                    Toggle("Knee Height (sitting)", isOn: $measurements[34]).padding(.horizontal)
                    Toggle("Thigh Clearance (sitting)", isOn: $measurements[35]).padding(.horizontal)
                    Toggle("Bideltoid Breadth", isOn: $measurements[36]).padding(.horizontal)
                    Toggle("Biacromial Breadth", isOn: $measurements[37]).padding(.horizontal)
                    Toggle("Hip Breadth (sitting)", isOn: $measurements[38]).padding(.horizontal)
                    Toggle("Abdomianl Depth", isOn: $measurements[39]).padding(.horizontal)
                    Toggle("Buttock-Knee Length", isOn: $measurements[40]).padding(.horizontal)
                }
                VStack{
                    Toggle("Finger Tip (right)", isOn: $measurements[41]).padding(.horizontal)
                    Toggle("Finger Tip (left)", isOn: $measurements[42]).padding(.horizontal)
                    Toggle("Hook (right)", isOn: $measurements[43]).padding(.horizontal)
                    Toggle("Hook (left)", isOn: $measurements[44]).padding(.horizontal)
                    Toggle("Thumb Tip (right)", isOn: $measurements[45]).padding(.horizontal)
                    Toggle("Thumb Tip (left)", isOn: $measurements[46]).padding(.horizontal)
                    Toggle("Grip (right)", isOn: $measurements[47]).padding(.horizontal)
                    Toggle("Grip (left)", isOn: $measurements[48]).padding(.horizontal)
                }
                
                //redundant button copies at bottom of form
                HStack{
                    //"create form" button to create the form and load all the chosen measurement labels into the appropriate string arrays
                    Button("Create Form"){
                        
                        //apply all selected labels and create the form
                        createForm()
                        
                    }.padding().background(.green).foregroundColor(.white).cornerRadius(10)//button visibility properties
                    
                    //buttons for toggling all values selected or de-selected
                    if selectAll{
                        Button("Deselect All"){
                            measurements = Array(repeating: false, count: 49)
                            selectAll = false
                        }.padding().background(.orange).foregroundColor(.white).cornerRadius(10)//button visibility properties
                    }
                    else{
                        Button("Reselect All"){
                            measurements = Array(repeating: true, count: 49)
                            selectAll = true
                        }.padding().background(.orange).foregroundColor(.white).cornerRadius(10)//button visibility properties
                    }
                }.padding()
                
                Divider().padding(/*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                
            }
        }.padding()
    }
    
    //MARK: methods
    func createForm(){
        if(measurements[1]){labels.append("Name")}
        if(measurements[2]){labels.append("Phone Number")}
        if(measurements[3]){labels.append("Email")}
        if(measurements[4]){labels.append("Age")}
        if(measurements[5]){labels.append("Aircraft")}
        if(measurements[6]){labels.append("Weight")}
        if(measurements[7]){labels.append("AFSC")}
        if(measurements[8]){labels.append("Gender")}
        if(measurements[9]){labels.append("Ethnicity")}
        if(measurements[10]){labelsStanding.append("Stature (standing)")}
        if(measurements[11]){labelsSitting.append("Stature (sitting)")}
        if(measurements[12]){labelsStanding.append("Eye Height (standing)")}
        if(measurements[13]){labelsSitting.append("Eye Height (sitting)")}
        if(measurements[14]){labelsStanding.append("Acromial Height (standing)")}
        if(measurements[15]){labelsSitting.append("Acromial Height (sitting)")}
        if(measurements[16]){labelsStanding.append("Suprasternale Height")}
        if(measurements[17]){labelsStanding.append("Waist Height")}
        if(measurements[18]){labelsStanding.append("Waist Front Length")}
        if(measurements[19]){labelsStanding.append("Chest Circumference @ Scye")}
        if(measurements[20]){labelsStanding.append("Chest Circumference")}
        if(measurements[21]){labelsStanding.append("Waist Circumference (omphalion)")}
        if(measurements[22]){labelsStanding.append("Waist Circumference (natural)")}
        if(measurements[23]){labelsStanding.append("Max Hip Circumference")}
        if(measurements[24]){labelsStanding.append("Thigh Circumference")}
        if(measurements[25]){labelsStanding.append("Vertical Trunk Circumference")}
        if(measurements[26]){labelsStanding.append("Kneeling Reach")}
        if(measurements[27]){labelsStanding.append("Arm Span")}
        if(measurements[28]){labelsStanding.append("Thumb Tip Reach average")}
        if(measurements[29]){labelsStanding.append("Overhead Reach (flat - shoes off)")}
        if(measurements[30]){labelsStanding.append("Overhead Reach (tiptoes - shoes off)")}
        if(measurements[31]){labelsStanding.append("Overhead Reach (flat - shoes/uniform on)")}
        if(measurements[32]){labelsStanding.append("Overhead Reach (tiptoes - shoes/uniform on)")}
        if(measurements[33]){labelsSitting.append("Overhead Reach (sitting)")}
        if(measurements[34]){labelsSitting.append("Knee Height (sitting)")}
        if(measurements[35]){labelsSitting.append("Thigh Clearance (sitting)")}
        if(measurements[36]){labelsSitting.append("Bideltoid Breadth")}
        if(measurements[37]){labelsSitting.append("Biacromial Breadth")}
        if(measurements[38]){labelsSitting.append("Hip Breadth (sitting)")}
        if(measurements[39]){labelsSitting.append("Abdomianl Depth")}
        if(measurements[40]){labelsSitting.append("Buttock-Knee Length")}
        if(measurements[41]){labelsSitting.append("Finger Tip (right)")}
        if(measurements[42]){labelsSitting.append("Finger Tip (left)")}
        if(measurements[43]){labelsSitting.append("Hook (right)")}
        if(measurements[44]){labelsSitting.append("Hook (left)")}
        if(measurements[45]){labelsSitting.append("Thumb Tip (right)")}
        if(measurements[46]){labelsSitting.append("Thumb Tip (left)")}
        if(measurements[47]){labelsSitting.append("Grip (right)")}
        if(measurements[48]){labelsSitting.append("Grip (left)")}
        
        withAnimation{
            
            //set newForm binding to false, return to "Form"
            newForm = false
            
        }
    }
}
