

import UIKit

class NewItemTableViewController: UITableViewController {
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var newItemTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        newItemTextField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
    }
    
    func saveNewItem() {
        let newItem = Items()
        newItem.item = newItemTextField.text!
        StorageManager.saveObject(newItem)
    }
}

extension NewItemTableViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if newItemTextField.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
