//
//  SimpleTest.swift
//  CommercialNotesUITests
//
//  Created by Anton Smirnov on 16.08.2021.
//

import Foundation
import XCTest

class SimpleTest: BaseTestCase {
    func testSimpleCreateNote() {
        MainPage(application: application)
            .tapAnonymous()
            .tapAddNote()
            .createNote(title: "Test note", text: "This is test note text")
    }
}
