//
//  CommercialNotesStorage.swift
//  CommercialNotes
//
//  Created by Anton Smirnov on 25.07.2021.
//

import CoreData


class CommercialNotesStorage {
    static let storage : CommercialNotesStorage = CommercialNotesStorage()
    
    private var noteIndexToIdDict : [Int:UUID] = [:]
    private var currentIndex : Int = 0
    
    private(set) var managedObjectContext : NSManagedObjectContext
    private var managedContextHasBeenSet : Bool = false
    
    private init() {
        managedObjectContext = NSManagedObjectContext(
            concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
    }
    
    func setManagedContext(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.managedContextHasBeenSet = true
        let notes = CommercialNotesCoreDataHelper.readNotesFromCoreData(fromManagedObjectContext: self.managedObjectContext)
        currentIndex = CommercialNotesCoreDataHelper.count
        for (index, note) in notes.enumerated() {
            noteIndexToIdDict[index] = note.noteId
        }
    }
    
    func addNote(noteToBeAdded: CommercialNotesModelData) {
        if managedContextHasBeenSet {
            noteIndexToIdDict[currentIndex] = noteToBeAdded.noteId
            CommercialNotesCoreDataHelper.createNoteInCoreData(
                noteToBeCreated:          noteToBeAdded,
                intoManagedObjectContext: self.managedObjectContext)
            currentIndex += 1
        }
    }
    
    func changeNote(noteToBeChanged: CommercialNotesModelData) {
        if managedContextHasBeenSet {
            var noteToBeChangedIndex : Int?
            noteIndexToIdDict.forEach { (index: Int, noteId: UUID) in
                if noteId == noteToBeChanged.noteId {
                    noteToBeChangedIndex = index
                    return
                }
            }
            if noteToBeChangedIndex != nil {
                CommercialNotesCoreDataHelper.changeNoteInCoreData(
                    noteToBeChanged: noteToBeChanged,
                    inManagedObjectContext: self.managedObjectContext)
            } else {
                // TODO error handling
            }
        }
    }
    
    func removeNote(at: Int) {
        if managedContextHasBeenSet {
            // check input index
            if at < 0 || at > currentIndex-1 {
                // TODO error handling
                return
            }
            let noteUUID = noteIndexToIdDict[at]
            CommercialNotesCoreDataHelper.deleteNoteFromCoreData(
                noteIdToBeDeleted:        noteUUID!,
                fromManagedObjectContext: self.managedObjectContext)
            if (at < currentIndex - 1) {
                for i in at ... currentIndex - 2 {
                    noteIndexToIdDict[i] = noteIndexToIdDict[i+1]
                }
            }
            noteIndexToIdDict.removeValue(forKey: currentIndex)
            currentIndex -= 1
        }
    }
    
    func readNote(at: Int) -> CommercialNotesModelData? {
        if managedContextHasBeenSet {
            if at < 0 || at > currentIndex-1 {
                // TODO error handling
                return nil
            }
            let noteUUID = noteIndexToIdDict[at]
            let noteReadFromCoreData: CommercialNotesModelData?
            noteReadFromCoreData = CommercialNotesCoreDataHelper.readNoteFromCoreData(
                noteIdToBeRead:           noteUUID!,
                fromManagedObjectContext: self.managedObjectContext)
            return noteReadFromCoreData
        }
        return nil
    }
    
    func count() -> Int {
        return CommercialNotesCoreDataHelper.count
    }
}
