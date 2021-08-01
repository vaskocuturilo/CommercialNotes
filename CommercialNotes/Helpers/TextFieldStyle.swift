//
//  TextFieldStyle.swift
//  CommercialNotes
//
//  Created by Anton Smirnov on 01.08.2021.
//

import Foundation
import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

class TextFieldStyle {
    
    static func styleTextField(_ textField:UITextField, indent: CGFloat) {
        
        textField.layer.cornerRadius = 27.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(indent, 0, 0)
    }
}
