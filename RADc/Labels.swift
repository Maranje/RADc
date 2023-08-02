//
//  Labels.swift
//  RADc
//
//  Created by Frank Maranje on 7/25/23 for STI-TEC, INC.
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
        "Ethnicity",
        "Race",
        "Rank",
        "Equipment"
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
        "Overhead Reach (tiptoes - shoes/uniform on)",
        "Stature (standing) [cm]",
        "Eye Height (standing) [cm]",
        "Acromial Height (standing) [cm]",
        "Suprasternale Height [cm]",
        "Waist Height [cm]",
        "Waist Front Length [cm]",
        "Chest Circumference @ Scye [cm]",
        "Chest Circumference [cm]",
        "Waist Circumference (omphalion) [cm]",
        "Waist Circumference (natural) [cm]",
        "Max Hip Circumference [cm]",
        "Thigh Circumference [cm]",
        "Vertical Trunk Circumference [cm]",
        "Kneeling Reach [cm]",
        "Arm Span [cm]",
        "Thumb Tip Reach average [cm]",
        "Overhead Reach (flat - shoes off) [cm]",
        "Overhead Reach (tiptoes - shoes off) [cm]",
        "Overhead Reach (flat - shoes/uniform on) [cm]",
        "Overhead Reach (tiptoes - shoes/uniform on) [cm]",
        "Stature (standing) [inches]",
        "Eye Height (standing) [inches]",
        "Acromial Height (standing) [inches]",
        "Suprasternale Height [inches]",
        "Waist Height [inches]",
        "Waist Front Length [inches]",
        "Chest Circumference @ Scye [inches]",
        "Chest Circumference [inches]",
        "Waist Circumference (omphalion) [inches]",
        "Waist Circumference (natural) [inches]",
        "Max Hip Circumference [inches]",
        "Thigh Circumference [inches]",
        "Vertical Trunk Circumference [inches]",
        "Kneeling Reach [inches]",
        "Arm Span [inches]",
        "Thumb Tip Reach average [inches]",
        "Overhead Reach (flat - shoes off) [inches]",
        "Overhead Reach (tiptoes - shoes off) [inches]",
        "Overhead Reach (flat - shoes/uniform on) [inches]",
        "Overhead Reach (tiptoes - shoes/uniform on) [inches]"
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
        "Abdominal Depth",
        "Buttock-Knee Length",
        "Finger Tip (right)",
        "Finger Tip (left)",
        "Hook (right)",
        "Hook (left)",
        "Thumb Tip (right)",
        "Thumb Tip (left)",
        "Grip (right)",
        "Grip (left)",
        "Stature (sitting) [cm]",
        "Eye Height (sitting) [cm]",
        "Acromial Height (sitting) [cm]",
        "Overhead Reach (sitting) [cm]",
        "Knee Height (sitting) [cm]",
        "Thigh Clearance (sitting) [cm]",
        "Bideltoid Breadth [cm]",
        "Biacromial Breadth [cm]",
        "Hip Breadth (sitting) [cm]",
        "Abdominal Depth [cm]",
        "Buttock-Knee Length [cm]",
        "Finger Tip (right) [cm]",
        "Finger Tip (left) [cm]",
        "Hook (right) [cm]",
        "Hook (left) [cm]",
        "Thumb Tip (right) [cm]",
        "Thumb Tip (left) [cm]",
        "Grip (right) [cm]",
        "Grip (left) [cm]",
        "Stature (sitting) [inches]",
        "Eye Height (sitting) [inches]",
        "Acromial Height (sitting) [inches]",
        "Overhead Reach (sitting) [inches]",
        "Knee Height (sitting) [inches]",
        "Thigh Clearance (sitting) [inches]",
        "Bideltoid Breadth [inches]",
        "Biacromial Breadth [inches]",
        "Hip Breadth (sitting) [inches]",
        "Abdominal Depth [inches]",
        "Buttock-Knee Length [inches]",
        "Finger Tip (right) [inches]",
        "Finger Tip (left) [inches]",
        "Hook (right) [inches]",
        "Hook (left) [inches]",
        "Thumb Tip (right) [inches]",
        "Thumb Tip (left) [inches]",
        "Grip (right) [inches]",
        "Grip (left) [inches]"
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


