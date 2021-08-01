//
//  ButtonStyle.swift
//  CommercialNotes
//
//  Created by Anton Smirnov on 01.08.2021.
//

import Foundation
import UIKit

class ButtonStyle {
    
    static func redStyleFilledButton(_ button:UIButton) {
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 255/255, green: 0/0, blue: 0/0, alpha: 0.7)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 255/255, green: 0/0, blue: 0/0, alpha: 0.7)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
       
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
}
