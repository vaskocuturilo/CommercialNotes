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
    
    private(set) var changingReallySimpleNote : CommercialNotesModelData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.delegate = self
        
        // check if we are in create mode or in change mode
        if let changingReallySimpleNote = self.changingReallySimpleNote {
            // in change mode: initialize for fields with data coming from note to be changed
            noteDateLabel.text = CommercialNotesDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
            noteTextView.text = changingReallySimpleNote.noteText
            noteTitleTextField.text = changingReallySimpleNote.noteTitle
            // enable done button by default
            noteDoneButton.isEnabled = true
        } else {
            // in create mode: set initial time stamp label
            noteDateLabel.text = CommercialNotesDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
        }
        
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
        // distinguish change mode and create mode
        if self.changingReallySimpleNote != nil {
            // change mode - change the item
            changeItem()
        } else {
            // create mode - create the item
            addItem()
        }
    }
    
    func setChangingReallySimpleNote(changingReallySimpleNote : CommercialNotesModelData) {
        self.changingReallySimpleNote = changingReallySimpleNote
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
    
    private func changeItem() -> Void {
        // get changed note instance
        if let changingReallySimpleNote = self.changingReallySimpleNote {
            // change the note through note storage
            CommercialNotesStorage.storage.changeNote(
                noteToBeChanged: CommercialNotesModelData(
                    noteId:        changingReallySimpleNote.noteId,
                    noteTitle:     noteTitleTextField.text!,
                    noteText:      noteTextView.text,
                    noteTimeStamp: noteCreationTimeStamp)
            )
            // navigate back to list of notes
            performSegue(
                withIdentifier: "backToMasterView",
                sender: self)
        } else {
            // create alert
            let alert = UIAlertController(
                title: "Unexpected error",
                message: "Cannot change the note, unexpected error occurred. Try again later.",
                preferredStyle: .alert)
            
            // add OK action
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default ) { (_) in self.performSegue(
                                withIdentifier: "backToMasterView",
                                sender: self)})
            // show alert
            self.present(alert, animated: true)
        }
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
        if self.changingReallySimpleNote != nil {
            // change mode
            noteDoneButton.isEnabled = true
        } else {
            // create mode
            if ( noteTitleTextField.text?.isEmpty ?? true ) || ( textView.text?.isEmpty ?? true ) {
                noteDoneButton.isEnabled = false
            } else {
                noteDoneButton.isEnabled = true
            }
        }
    }
}
