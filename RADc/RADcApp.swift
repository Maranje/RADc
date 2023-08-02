//
//  RADcApp.swift
//  RADc
//
//  Created by Frank Maranje on 7/14/23 for STI-TEC, INC.
//

import SwiftUI

@main
struct RADcApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: DocumentHandler()) { file in
            AnthroForm(document: file.$document)
        }
    }
}
