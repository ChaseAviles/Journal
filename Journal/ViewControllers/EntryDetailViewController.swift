//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Johnathan Aviles on 1/11/21.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry?
    var journal: Journal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        updateViews()
        
    }
    
    // MARK: - Actions
    @IBAction func clearTextButton(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // guard let protects against a nil value, if let allows you to do something upon a condition
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty,
              let journal = journal else { return }
        if let entry = entry {
            EntryController.update(entry: entry, title: title, body: body) 
        } else {
            EntryController.createEntryWith(title: title, body: body, journal: journal)
//            JournalController.shared.saveToPersistenceStore()
        }
        navigationController?.popViewController(animated: true)
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }   
}
