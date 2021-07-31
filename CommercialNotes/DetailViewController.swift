//
//  DetailViewController.swift
//  CommercialNotes
//
//  Created by Anton Smirnov on 26.07.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var noteTitleLabel: UILabel!
    
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let topicLabel = noteTitleLabel,
               let dateLabel = noteDateLabel,
               let textView = noteTextView {
                topicLabel.text = detail.noteTitle
                dateLabel.text = CommercialNotesDateHelper.convertDate(date: Date.init(seconds: detail.noteTimeStamp))
                textView.text = detail.noteText
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    var detailItem: CommercialNotesModelData? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChangeNoteSegue" {
            let changeNoteViewController = segue.destination as! CommercialNoteCreateChangeViewController
            if let detail = detailItem {
                changeNoteViewController.setChangingReallySimpleNote(
                    changingReallySimpleNote: detail)
            }
        }
    }
}
