//
//  NotesPage.swift
//  CommercialNotesUITests
//
//  Created by Anton Smirnov on 16.08.2021.
//

import Foundation
import XCTest

struct NotesPage: Page {
    
    let application: XCUIApplication
    
    private enum Identifiers {
        static let editButton = "Edit"
        static let addButton = "annotate"
    }
    
    func tapAddNote() -> CreateNotePage {
        let addButton = application.buttons[Identifiers.addButton]
        addButton.tap()
        
        return CreateNotePage(application: application)
    }
}
