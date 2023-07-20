//
//  DataEntryField.swift
//  RADc
//
//  Created by Frank Maranje on 7/17/23 for STI-TEC, INC.
//

import SwiftUI

struct DataEntryField: View{
    
    //MARK: properties
    let label: String
    let labelWidthMultiplier: Double
    let labelColor: Color
    @Binding var participants: [Participant]
    @Binding var currentParticipant: Participant
    @Binding var fontSize: Double
    @Binding var units: Bool
    @State var autoCap = false
    @State var foreColor: Color = .white
    @State var setLabelColor: Color = .gray
    
    //MARK: boundary values
    //reference list for storing boundary values, [upper bound, lower bound]
    //(to do: refine these values to 2 std. dev. from their respective means)
    let boundsReference: [String: [Double]] = [
        "Stature, standing" : [85.64, 53.68],
        "Stature, sitting" : [43.43, 29.01],
        "Eye Height, standing" : [76, 43.89],
        "Eye Height, sitting" : [38.23, 23.72],
        "Acromial Height, standing" : [71.97, 41.66],
        "Acromial Height, sitting" : [29.61, 17.45],
        "Suprasternale Height" : [71.04, 42.11],
        "Waist Height, omphalion" : [55.38, 29.86],
        "Waist Front Length" : [22.43, 11.47],
        "Chest Circumference @ Scye" : [56.24, 26.63],
        "Chest Circumference" : [55.85, 25.09],
        "Waist Circumference, omphalion" : [53.45, 18.95],
        "Waist Circumference, natural" : [50, 19.65],
        "Max Hip Circumference" : [53, 30],
        "Thigh Circumference" : [21.41, 9.73],
        "Vertical Trunk Circumference" : [81.1, 48.07],
        "Kneeling Reach" : [26, 10],
        "Arm Span" : [85.64, 53.68],
        "Thumb Tip Reach, average" : [41.66, 22.98],
        "Overhead Reach, flat, shoes off" : [114.01, 62.17],
        "Overhead Reach, tiptoes, shoes off" : [114.01, 62.17],
        "Overhead Reach, flat, shoes/uniform on" : [114.01, 62.17],
        "Overhead Reach, tiptoes, shoes/uniform on" : [114.01, 62.17],
        "Overhead Reach, sitting" : [71.29, 41.19],
        "Knee Height, sitting" : [28.77, 15.69],
        "Thigh Clearance, sitting" : [9.64, 4.9],
        "Bideltoid Breadth" : [25.4, 14.12],
        "Biacromial Breadth" : [30, 10],
        "Hip Breadth, sitting" : [21.06, 9.75],
        "Abdomianl Depth" : [14.1, 4.51],
        "Buttock-Knee Length" : [31.1, 16.9],
        "Finger Tip, right" : [20, 3],
        "Finger Tip, left" : [20, 3],
        "Hook, right" : [20, 3],
        "Hook, left" : [20, 3],
        "Thumb Tip, right" : [20, 3],
        "Thumb Tip, left" : [20, 3],
        "Grip, right" : [20, 3],
        "Grip, left" : [20, 3]
    ]
    
    //MARK: data entry field body
    var body: some View{
        //procedurally generated text entry fields
        HStack{
            //text field for data entry
            TextField(label, text:
                Binding(
                    get: {
                        currentParticipant.properties[label] ?? ""
                    },
                    set: {newValue in
                        //save to currentParticipant to display values on form
                        currentParticipant.properties[label] = newValue
                        //save from currentParticipant to corresponding participant in participants array
                        participants.enumerated().forEach{index, participant in
                            if participant.pNum == currentParticipant.pNum{
                                participants[index].properties[label] = newValue
                            }
                        }
                    }
                )
            )
            .onAppear(perform: checkName)
            .autocapitalization(autoCap ? .words : .none)
            .disableAutocorrection(true)
            
            Spacer()
            
            //text field label, appears after data has been entered
            if !(currentParticipant.properties[label]?.isEmpty ?? true) {
                Text(label)
                    .frame(width: fontSize * labelWidthMultiplier)
                    .font(.system(size: fontSize * 0.8))
                    .foregroundColor(foreColor)
                    .background(checkBounds() ? labelColor : .red)
                    .cornerRadius(5)
            }
        }
    }
    
    //MARK: methods
    func checkName(){ //check if the current label is "Name" in order to set autocap on for individual word
        if label == "Name"{
            autoCap = true
        }
    }
    
    func checkBounds()->Bool{ //check if user input for current label is within bounds
        
        //confirm that the current label exists within the bounds reference
        if let valueCheck = boundsReference[label] {
            //set upper bounds according to units
            let upper = units ? valueCheck[0] * 2.54 : valueCheck[0]
            //set lower bounds according to units
            let lower = units ? valueCheck[1] * 2.54 : valueCheck[1]
            //convert the value in the text field from a string to a double
            let value = Double(currentParticipant.properties[label]?.trimmingCharacters(in: .whitespaces) ?? "0") ?? 0
            
            //check boundary compliance
            if upper < value || lower > value {
                return false
            }
        }
        return true
    }
}
