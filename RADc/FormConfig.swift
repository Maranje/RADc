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
    @State private var selectedOption = 0
    let options = ["custom", "T-1", "WSU PASSfit"]
    
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
                            measurements = Array(repeating: false, count: 81)
                            selectAll = false
                            selectedOption = 0
                        }.padding().background(.orange).foregroundColor(.white).cornerRadius(10)//button visibility properties
                    }
                    else{
                        Button("Reselect All"){
                            measurements = Array(repeating: true, count: 81)
                            selectAll = true
                            selectedOption = 0
                        }.padding().background(.orange).foregroundColor(.white).cornerRadius(10)//button visibility properties
                    }
                    
                    Picker("Preset Studies", selection: $selectedOption){
                        ForEach(0..<options.count, id: \.self){ index in
                            Text(options[index]).tag(index)
                        }
                    }
                    .pickerStyle(DefaultPickerStyle()).frame(width: 180)
                    .onChange(of: selectedOption) { newValue in
                        if newValue == 1 { t1Config() }
                        if newValue == 2 { WNUconfig() }
                    }
                }
                
                VStack{
                    //allow user to assign all the desired labels in the form
                    VStack{
                        Toggle("Name", isOn: $measurements[1]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Phone Number", isOn: $measurements[2]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Email", isOn: $measurements[3]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Age", isOn: $measurements[4]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Aircraft", isOn: $measurements[5]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Weight", isOn: $measurements[6]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("AFSC", isOn: $measurements[7]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Gender", isOn: $measurements[8]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Ethnicity", isOn: $measurements[9]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Race", isOn: $measurements[10]).padding(.horizontal).onTapGesture{selectedOption = 0}
                    }
                    VStack{
                        Toggle("Rank", isOn: $measurements[11]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Equipment", isOn: $measurements[12]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Stature (standing)", isOn: $measurements[13]).padding(.horizontal).onTapGesture{selectedOption = 0}
                    }
                    VStack{
                        Toggle("Sitting Height", isOn: $measurements[14]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Eye Height (standing)", isOn: $measurements[15]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Eye Height (sitting)", isOn: $measurements[16]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Acromial Height (standing)", isOn: $measurements[17]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Acromial Height (sitting)", isOn: $measurements[18]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Suprasternale Height", isOn: $measurements[19]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Waist Height", isOn: $measurements[20]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Waist Front Length", isOn: $measurements[21]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Chest Circumference @ Scye", isOn: $measurements[22]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Chest Circumference", isOn: $measurements[23]).padding(.horizontal).onTapGesture{selectedOption = 0}
                    }
                    VStack{
                        Toggle("Waist Circumference (omphalion)", isOn: $measurements[24]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Waist Circumference (natural)", isOn: $measurements[25]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Max Hip Circumference", isOn: $measurements[26]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Thigh Circumference", isOn: $measurements[27]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Vertical Trunk Circumference", isOn: $measurements[28]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Kneeling Reach", isOn: $measurements[29]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Arm Span", isOn: $measurements[30]).padding(.horizontal).onTapGesture{selectedOption = 0}
                    }
                    VStack{
                        Toggle("Thumb Tip Reach 1", isOn: $measurements[31]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Thumb Tip Reach 2", isOn: $measurements[32]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Thumb Tip Reach 3", isOn: $measurements[33]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Thumb Tip Reach average", isOn: $measurements[34]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Overhead Reach (flat - shoes off)", isOn: $measurements[35]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Overhead Reach (tiptoes - shoes off)", isOn: $measurements[36]).padding(.horizontal).onTapGesture{selectedOption = 0}
                    }
                    VStack{
                        Toggle("Overhead Reach (flat - shoes/uniform on)", isOn: $measurements[37]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Overhead Reach (tiptoes - shoes/uniform on)", isOn: $measurements[38]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Overhead Reach (sitting)", isOn: $measurements[39]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Knee Height (sitting)", isOn: $measurements[40]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Thigh Clearance (sitting)", isOn: $measurements[41]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Bideltoid Breadth", isOn: $measurements[42]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Biacromial Breadth", isOn: $measurements[43]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Hip Breadth (sitting)", isOn: $measurements[44]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Abdominal Depth", isOn: $measurements[45]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Buttock-Knee Length", isOn: $measurements[46]).padding(.horizontal).onTapGesture{selectedOption = 0}
                    }
                    VStack{
                        Toggle("Head Circumference", isOn: $measurements[47]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Head Breadth", isOn: $measurements[48]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Head Length", isOn: $measurements[49]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Tragion to Top of Head", isOn: $measurements[50]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Menton-Sellion Length", isOn: $measurements[51]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Bizygomatic Breadth", isOn: $measurements[52]).padding(.horizontal).onTapGesture{selectedOption = 0}
                    }
                    VStack{
                        Toggle("Finger Tip (right)", isOn: $measurements[53]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Finger Tip (left)", isOn: $measurements[54]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Hook (right)", isOn: $measurements[55]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Hook (left)", isOn: $measurements[56]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Thumb Tip (right)", isOn: $measurements[57]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Thumb Tip (left)", isOn: $measurements[58]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Grip (right)", isOn: $measurements[59]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Grip (left)", isOn: $measurements[60]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Pinky (right)", isOn: $measurements[61]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Pinky (left)", isOn: $measurements[62]).padding(.horizontal).onTapGesture{selectedOption = 0}
                    }
                    VStack{
                        Toggle("Buttock Circumference", isOn: $measurements[63]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Chest Breadth", isOn: $measurements[64]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Chest Depth", isOn: $measurements[65]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Middle Chest Width", isOn: $measurements[66]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Under Bust Circumference", isOn: $measurements[67]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Right Sternal Notch Nipple Length", isOn: $measurements[68]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Left Sternal Notch Nipple Length", isOn: $measurements[69]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Right Clavicle Nipple Length", isOn: $measurements[70]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Left Clavicle Nipple Length", isOn: $measurements[71]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Right Medial Mammary Radius", isOn: $measurements[72]).padding(.horizontal).onTapGesture{selectedOption = 0}
                    }
                    VStack{
                        Toggle("Left Medial Mammary Radius", isOn: $measurements[73]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Right Lateral Mammary Radius", isOn: $measurements[74]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Left Lateral Mammary Radius", isOn: $measurements[75]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Right Nipple Inframammary Fold Length", isOn: $measurements[76]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Left Nipple Inframammary Fold Length", isOn: $measurements[77]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Right Mammary Projection", isOn: $measurements[78]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Left Mammary Projection", isOn: $measurements[79]).padding(.horizontal).onTapGesture{selectedOption = 0}
                        Toggle("Nipple-Nipple Distance", isOn: $measurements[80]).padding(.horizontal).onTapGesture{selectedOption = 0}
                    }
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
                            measurements = Array(repeating: false, count: 58)
                            selectAll = false
                        }.padding().background(.orange).foregroundColor(.white).cornerRadius(10)//button visibility properties
                    }
                    else{
                        Button("Reselect All"){
                            measurements = Array(repeating: true, count: 58)
                            selectAll = true
                        }.padding().background(.orange).foregroundColor(.white).cornerRadius(10)//button visibility properties
                    }
                }.padding()
                
                Divider().padding(/*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                
            }
        }.padding()
    }
    
    //MARK: methods
    func t1Config(){
        measurements = Array(repeating: true, count: 81)
        let setFalse = [10, 11, 12, 29, 35, 36, 37, 38, 47, 48, 49, 50, 51, 52]
        for index in setFalse{
            measurements[index] = false
        }
    }
    
    func WNUconfig(){
        measurements = Array(repeating: false, count: 81)
        let setTrue = [1, 2, 3, 4, 6, 8, 9, 13, 14, 24, 25, 31, 32, 33, 34, 40, 42, 44, 45, 46,
                        63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]
        for index in setTrue{
            measurements[index] = true
        }
    }
    
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
        if(measurements[10]){labels.append("Race")}
        if(measurements[11]){labels.append("Rank")}
        if(measurements[12]){labels.append("Equipment")}
        if(measurements[13]){labelsStanding.append("Stature (standing)")}
        if(measurements[14]){labelsSitting.append("Sitting Height")}
        if(measurements[15]){labelsStanding.append("Eye Height (standing)")}
        if(measurements[16]){labelsSitting.append("Eye Height (sitting)")}
        if(measurements[17]){labelsStanding.append("Acromial Height (standing)")}
        if(measurements[18]){labelsSitting.append("Acromial Height (sitting)")}
        if(measurements[19]){labelsStanding.append("Suprasternale Height")}
        if(measurements[20]){labelsStanding.append("Waist Height")}
        if(measurements[21]){labelsStanding.append("Waist Front Length")}
        if(measurements[22]){labelsStanding.append("Chest Circumference @ Scye")}
        if(measurements[23]){labelsStanding.append("Chest Circumference")}
        if(measurements[24]){labelsStanding.append("Waist Circumference (omphalion)")}
        if(measurements[25]){labelsStanding.append("Waist Circumference (natural)")}
        if(measurements[26]){labelsStanding.append("Max Hip Circumference")}
        if(measurements[27]){labelsStanding.append("Thigh Circumference")}
        if(measurements[28]){labelsStanding.append("Vertical Trunk Circumference")}
        if(measurements[29]){labelsStanding.append("Kneeling Reach")}
        if(measurements[30]){labelsStanding.append("Arm Span")}
        if(measurements[31]){labelsStanding.append("Thumb Tip Reach 1")}
        if(measurements[32]){labelsStanding.append("Thumb Tip Reach 2")}
        if(measurements[33]){labelsStanding.append("Thumb Tip Reach 3")}
        if(measurements[34]){labelsStanding.append("Thumb Tip Reach average")}
        if(measurements[35]){labelsStanding.append("Overhead Reach (flat - shoes off)")}
        if(measurements[36]){labelsStanding.append("Overhead Reach (tiptoes - shoes off)")}
        if(measurements[37]){labelsStanding.append("Overhead Reach (flat - shoes/uniform on)")}
        if(measurements[38]){labelsStanding.append("Overhead Reach (tiptoes - shoes/uniform on)")}
        if(measurements[39]){labelsSitting.append("Overhead Reach (sitting)")}
        if(measurements[40]){labelsSitting.append("Knee Height (sitting)")}
        if(measurements[41]){labelsSitting.append("Thigh Clearance (sitting)")}
        if(measurements[42]){labelsSitting.append("Bideltoid Breadth")}
        if(measurements[43]){labelsSitting.append("Biacromial Breadth")}
        if(measurements[44]){labelsSitting.append("Hip Breadth (sitting)")}
        if(measurements[45]){labelsSitting.append("Abdominal Depth")}
        if(measurements[46]){labelsSitting.append("Buttock-Knee Length")}
        if(measurements[47]){labelsSitting.append("Head Circumference")}
        if(measurements[48]){labelsSitting.append("Head Breadth")}
        if(measurements[49]){labelsSitting.append("Head Length")}
        if(measurements[50]){labelsSitting.append("Tragion to Top of Head")}
        if(measurements[51]){labelsSitting.append("Menton-Sellion Length")}
        if(measurements[52]){labelsSitting.append("Bizygomatic Breadth")}
        if(measurements[53]){labelsSitting.append("Finger Tip (right)")}
        if(measurements[54]){labelsSitting.append("Finger Tip (left)")}
        if(measurements[55]){labelsSitting.append("Hook (right)")}
        if(measurements[56]){labelsSitting.append("Hook (left)")}
        if(measurements[57]){labelsSitting.append("Thumb Tip (right)")}
        if(measurements[58]){labelsSitting.append("Thumb Tip (left)")}
        if(measurements[59]){labelsSitting.append("Grip (right)")}
        if(measurements[60]){labelsSitting.append("Grip (left)")}
        if(measurements[61]){labelsSitting.append("Pinky (right)")}
        if(measurements[62]){labelsSitting.append("Pinky (left)")}
        if(measurements[63]){labelsSitting.append("Buttock Circumference")}
        if(measurements[64]){labelsSitting.append("Chest Breadth")}
        if(measurements[65]){labelsSitting.append("Chest Depth")}
        if(measurements[66]){labelsSitting.append("Middle Chest Width")}
        if(measurements[67]){labelsSitting.append("Under Bust Circumference")}
        if(measurements[68]){labelsSitting.append("Right Sternal Notch Nipple Length")}
        if(measurements[69]){labelsSitting.append("Left Sternal Notch Nipple Length")}
        if(measurements[70]){labelsSitting.append("Right Clavicle Nipple Length")}
        if(measurements[71]){labelsSitting.append("Left Clavicle Nipple Length")}
        if(measurements[72]){labelsSitting.append("Right Medial Mammary Radius")}
        if(measurements[73]){labelsSitting.append("Left Medial Mammary Radius")}
        if(measurements[74]){labelsSitting.append("Right Lateral Mammary Radius")}
        if(measurements[75]){labelsSitting.append("Left Lateral Mammary Radius")}
        if(measurements[76]){labelsSitting.append("Right Nipple Inframammary Fold Length")}
        if(measurements[77]){labelsSitting.append("Left Nipple Inframammary Fold Length")}
        if(measurements[78]){labelsSitting.append("Right Mammary Projection")}
        if(measurements[79]){labelsSitting.append("Left Mammary Projection")}
        if(measurements[80]){labelsSitting.append("Nipple-Nipple Distance")}
        
        withAnimation{
            
            //set newForm binding to false, return to "Form"
            newForm = false
            
        }
    }
}
