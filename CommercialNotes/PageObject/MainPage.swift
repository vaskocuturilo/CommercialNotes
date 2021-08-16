//
//  File.swift
//  CommercialNotesUITests
//
//  Created by Anton Smirnov on 16.08.2021.
//

import Foundation
import XCTest

struct MainPage: Page {
    
    let application: XCUIApplication
    
    
    private enum Identifiers {
        static let loginButton = "Login"
        static let signUpButton = "Sign Up"
        static let anonymousButton = "Anonymous"
    }
    
    func tapAnonymous() -> NotesPage {
        application.buttons[Identifiers.anonymousButton].tap()
        
        return NotesPage(application: application)
    }
}
