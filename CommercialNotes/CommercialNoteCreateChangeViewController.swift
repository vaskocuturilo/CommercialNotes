//
//  CommercialNoteCreateChangeViewController.swift
//  CommercialNotes
//
//  Created by Anton Smirnov on 25.07.2021.
//

import UIKit

class CommercialNoteCreateChangeViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteDoneButton: UIButton!
    
    private let noteCreationTimeStamp : Int64 = Date().toSeconds()
    
    private(set) var changingReallySimpleNote : CommercialNotesModelData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.delegate = self
        
        if let changingReallySimpleNote = self.changingReallySimpleNote {
            noteDateLabel.text = CommercialNotesDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
            noteTextView.text = changingReallySimpleNote.noteText
            noteTitleTextField.text = changingReallySimpleNote.noteTitle
            noteDoneButton.isEnabled = true
        } else {
            noteDateLabel.text = CommercialNotesDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
        }
        
        noteTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        noteTextView.layer.borderWidth = 1.0
        noteTextView.layer.cornerRadius = 5
        
//        let backButton = UIBarButtonItem()
//        backButton.title = "Back"
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
//        self.navigationController?.navigationBar.topItem?.
//        
        let backBTN = UIBarButtonItem(image: UIImage(named: "Image-2"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        if self.changingReallySimpleNote != nil {
            changeItem()
        } else {
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
        if let changingReallySimpleNote = self.changingReallySimpleNote {
            CommercialNotesStorage.storage.changeNote(
                noteToBeChanged: CommercialNotesModelData(
                    noteId:        changingReallySimpleNote.noteId,
                    noteTitle:     noteTitleTextField.text!,
                    noteText:      noteTextView.text,
                    noteTimeStamp: noteCreationTimeStamp)
            )
            performSegue(
                withIdentifier: "backToMasterView",
                sender: self)
        } else {
            let alert = UIAlertController(
                title: "Unexpected error",
                message: "Cannot change the note, unexpected error occurred. Try again later.",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default ) { (_) in self.performSegue(
                                withIdentifier: "backToMasterView",
                                sender: self)})
            self.present(alert, animated: true)
        }
    }
    
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
