//
//  CommercialNoteUITableViewCell.swift
//  CommercialNotes
//
//  Created by Anton Smirnov on 25.07.2021.
//

import UIKit

class CommercialNoteUITableViewCell: UITableViewCell {
    
    private(set) var noteTitle : String = ""
    private(set) var noteText  : String = ""
    private(set) var noteDate  : String = ""
    
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteTextLabel: UILabel!
}
