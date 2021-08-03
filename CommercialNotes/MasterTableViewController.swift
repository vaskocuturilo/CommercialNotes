//
//  MasterTableViewController.swift
//  CommercialNotes
//
//  Created by Anton Smirnov on 25.07.2021.
//

import UIKit

class MasterTableViewController: UITableViewController{
    
    var detailViewController: DetailViewController? = nil
    
    private let composeButton: UIButton = {
        
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setImage(UIImage(systemName: "square.and.pencil",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)),for: .normal)
        button.layer.cornerRadius = 40
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            let alert = UIAlertController(
                title: "Could note get app delegate",
                message: "Could note get app delegate, unexpected error occurred. Try again later.",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default))
            self.present(alert, animated: true)
            
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        CommercialNotesStorage.storage.setManagedContext(managedObjectContext: managedContext)
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        view.addSubview(composeButton)
        composeButton.addTarget(self, action:#selector(insertNewObject(_:)), for:.touchUpInside )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        composeButton.frame = CGRect(x: view.frame.width - 80 - 40,
                                     y: view.frame.height - 80 - 70 - view.safeAreaInsets.bottom,
                                     width: 80,
                                     height: 80)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // clearsSelectionOnViewWillAppear = (detailViewController != nil)
        super.viewWillAppear(animated)
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        performSegue(withIdentifier: "showCreateNoteSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //let object = objects[indexPath.row]
                let object = CommercialNotesStorage.storage.readNote(at: indexPath.row)
                let controller = segue.destination as! DetailViewController
                controller.detailItem = object
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return CommercialNotesStorage.storage.count()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommercialNoteUITableViewCell
        
        if let object = CommercialNotesStorage.storage.readNote(at: indexPath.row) {
            cell.noteTitleLabel!.text = object.noteTitle
            cell.noteTextLabel!.text = object.noteText
            cell.noteDateLabel!.text = CommercialNotesDateHelper.convertDate(date: Date.init(seconds: object.noteTimeStamp))
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: self)
        
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CommercialNotesStorage.storage.removeNote(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
