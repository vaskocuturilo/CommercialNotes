//
//  LoginViewController.swift
//  CommercialNotes
//
//  Created by Anton Smirnov on 01.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var facebookLogin: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        ButtonStyle.redStyleFilledButton(loginButton)
        ButtonStyle.facebookStyleFilledButton(facebookLogin)
        
        TextFieldStyle.styleTextField(emailField, indent: 10)
        TextFieldStyle.styleTextField(passwordField, indent: 10)
        
        // Do any additional setup after loading the view.
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
