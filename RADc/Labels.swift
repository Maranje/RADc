//
//  Labels.swift
//  RADc
//
//  Created by Frank Maranje on 7/25/23.
//

import Foundation

struct Labels{
    
    //MARK: properties
    private let labels: [String] = [
        "Name",
        "Phone Number",
        "Email",
        "Age",
        "Aircraft",
        "Weight",
        "AFSC",
        "Gender",
        "Ethnicity"
    ]
    private let labelsStanding: [String] = [
        "Stature (standing)",
        "Eye Height (standing)",
        "Acromial Height (standing)",
        "Suprasternale Height",
        "Waist Height",
        "Waist Front Length",
        "Chest Circumference @ Scye",
        "Chest Circumference",
        "Waist Circumference (omphalion)",
        "Waist Circumference (natural)",
        "Max Hip Circumference",
        "Thigh Circumference",
        "Vertical Trunk Circumference",
        "Kneeling Reach",
        "Arm Span",
        "Thumb Tip Reach average",
        "Overhead Reach (flat - shoes off)",
        "Overhead Reach (tiptoes - shoes off)",
        "Overhead Reach (flat - shoes/uniform on)",
        "Overhead Reach (tiptoes - shoes/uniform on)"
    ]
    private let labelsSitting: [String] = [
        "Stature (sitting)",
        "Eye Height (sitting)",
        "Acromial Height (sitting)",
        "Overhead Reach (sitting)",
        "Knee Height (sitting)",
        "Thigh Clearance (sitting)",
        "Bideltoid Breadth",
        "Biacromial Breadth",
        "Hip Breadth (sitting)",
        "Abdomianl Depth",
        "Buttock-Knee Length",
        "Finger Tip (right)",
        "Finger Tip (left)",
        "Hook (right)",
        "Hook (left)",
        "Thumb Tip (right)",
        "Thumb Tip (left)",
        "Grip (right)",
        "Grip (left)"
    ]
    
    
    //MARK: methods
    public func checkLabels(label: String) -> Bool{
        if labels.contains(label) { return true }
        else { return false }
    }
    
    public func checkLabelsStanding(label: String) -> Bool{
        if labelsStanding.contains(label) { return true }
        return false
    }
    
    public func checkLabelsSitting(label: String) -> Bool{
        if labelsSitting.contains(label) { return true }
        return false
    }
}


