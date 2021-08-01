//
//  SignUpViewController.swift
//  CommercialNotes
//
//  Created by Anton Smirnov on 01.08.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // Do any additional setup after loading the view.
        
        ButtonStyle.facebookStyleFilledButton(signUpButton)
        
        TextFieldStyle.styleTextField(fullNameField, indent: 10)
        TextFieldStyle.styleTextField(emailField, indent: 10)
        TextFieldStyle.styleTextField(passwordField, indent: 10)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
