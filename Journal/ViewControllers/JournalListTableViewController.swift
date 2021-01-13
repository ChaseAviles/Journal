//
//  JournalListTableViewController.swift
//  Journal
//
//  Created by Johnathan Aviles on 1/11/21.
//

import UIKit

class JournalListTableViewController: UITableViewController {
    
    var journal: Journal?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        guard let entry = journal?.entries[indexPath.row] else { return UITableViewCell()}
        
        cell.textLabel?.text = entry.title

        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let journal = journal else { return }
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.deleteEntry(entry: entryToDelete, journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let journal = journal,
                  let destination = segue.destination as? EntryDetailViewController else { return }
            if segue.identifier == "showEntry" {
                guard let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? EntryDetailViewController else { return }
                let entryToSend = journal.entries[indexPath.row]
                destination.journal = journal
                destination.entry = entryToSend
            } else if segue.identifier == "createNewEntry" {
                destination.journal = journal
            }
        }
}
