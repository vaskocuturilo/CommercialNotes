//
//  CreateNotePage.swift
//  CommercialNotesUITests
//
//  Created by Anton Smirnov on 16.08.2021.
//

import Foundation
import XCTest

struct CreateNotePage: Page {
    
    let application: XCUIApplication
    
    private enum Identifiers {
        static let titleField = "New Note 1"
        static let textView = "noteTextView"
        static let approveButton = "Ok"
    }
    
    
    func createNote(title: String, text: String) -> Self {
        let titleField = application.textFields[Identifiers.titleField]
        let textView = application.textViews[Identifiers.textView]
        let approveButton = application.buttons[Identifiers.approveButton]
        
        titleField.tap()
        titleField.typeText(title)
        
        textView.tap()
        textView.typeText(text)
        
        approveButton.tap()
        
        return self
    }
    
}
