//
//  CommercialNoteCreateChangeViewController.swift
//  CommercialNotes
//
//  Created by Anton Smirnov on 25.07.2021.
//

import UIKit

class CommercialNoteCreateChangeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteDoneButton: UIButton!
    
    private let noteCreationTimeStamp : Int64 = Date().toSeconds()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.delegate = self
        
        // Do any additional setup after loading the view.
        noteDateLabel.text = CommercialNotesDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
        
        // initialize text view UI - border width, radius and color
        noteTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        noteTextView.layer.borderWidth = 1.0
        noteTextView.layer.cornerRadius = 5
        
        // For back button in navigation bar, change text
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        addItem()
    }
    
    private func addItem() -> Void {
        let note = CommercialNotesModelData(
            noteTitle:     noteTitleTextField.text!,
            noteText:      noteTextView.text,
            noteTimeStamp: noteCreationTimeStamp)
        
        CommercialNotesStorage.storage.addNote(noteToBeAdded: note)
        
        performSegue(
            withIdentifier: "backToMasterView",
            sender: self)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //Handle the text changes here
    func textViewDidChange(_ textView: UITextView) {
        // create mode
        if ( noteTitleTextField.text?.isEmpty ?? true ) || ( textView.text?.isEmpty ?? true ) {
            noteDoneButton.isEnabled = false
        } else {
            noteDoneButton.isEnabled = true
        }
    }
}
