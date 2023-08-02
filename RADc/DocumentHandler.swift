//
//  DocumentHandler.swift
//  RADc
//
//  Created by Frank Maranje on 7/25/23 for STI-TEC, INC.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var anthro: UTType {
        UTType(importedAs: "com.microsoft.excel.xls")
    }
}

struct DocumentHandler: FileDocument {
    var text: String
    var fileName: String

    init(text: String = "") {
        self.text = text
        fileName = ""
    }

    static var readableContentTypes: [UTType] { [.anthro] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
        fileName = configuration.file.filename?.replacingOccurrences(of: ".xls", with: "") ?? ""
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
