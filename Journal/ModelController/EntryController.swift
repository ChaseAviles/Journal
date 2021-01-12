//
//  EntryController.swift
//  Journal
//
//  Created by Johnathan Aviles on 1/11/21.
//

import Foundation

class EntryController{
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
   //create
    func createEntryWith(title: String, body: String){
        let newEntry = Entry(title: title, body: body)
        entries.append(newEntry)
        saveToPersistenceStorage()
    }
    
    //delete
    func deleteEntry(entryToDelete: Entry){
        guard let index = entries.firstIndex(of: entryToDelete) else { return }
        entries.remove(at: index)
        saveToPersistenceStorage()
    }
    
    private func fileURL() -> URL {
     let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
     return documentsDirectoryURL
    }
    
    func saveToPersistenceStorage(){
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: fileURL())
        } catch{
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistenceStore(){
        do{
            let data = try Data(contentsOf: fileURL())
            let entries = try JSONDecoder().decode([Entry].self, from: data)
            self.entries = entries
        } catch{
            print(error)
            print(error.localizedDescription)
        }
    }
}



