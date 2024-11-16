// Abstract: Delegate methods to handle text field events on details view as user types in the color name text field

import UIKit

extension ColorDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleNameChange(newName: textField.text)
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newNameString = textField.text
        
        if string.isEmpty {
            newNameString?.removeLast()
        } else {
            newNameString?.append(string)
        }
        
        handleNameChange(newName: newNameString)
        return true
    }
    
    private func handleNameChange(newName string: String?) {
        guard
            let newNameString = string,
            !newNameString.isEmpty
        else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            newName = nil
            return
        }
        navigationItem.rightBarButtonItem?.isEnabled = true
        newName = newNameString
    }
}
