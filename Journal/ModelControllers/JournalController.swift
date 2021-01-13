//
//  JournalController.swift
//  Journal
//
//  Created by Johnathan Aviles on 1/12/21.
//

import Foundation

class JournalController {
    // shared property
    static let shared = JournalController()
    
    // Jounal array property set to empty array of journal
    var journals: [Journal] = []
    
    // Create journal function
    func createJournalWith(title: String){
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        saveToPersistentStorage()
    }
    // Create delete journal function
    func delete(journal: Journal){
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        saveToPersistentStorage()
    }
    
    //create add entry to function
    func addEntryTo(journal: Journal, entry: Entry){
        journal.entries.append(entry)
        saveToPersistentStorage()
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry){
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        journals.remove(at: index)
        saveToPersistentStorage()
    }
    
    // MARK: - Persistence
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            let journals = try JSONDecoder().decode([Journal].self, from: data)
            self.journals = journals
        } catch {
            print(error.localizedDescription)
        }
    }
}
