// Abstract: Delegate methods to handle text field events on details view as user types in the color name text field

import UIKit

extension ColorDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        respondToTextFieldChange(textField)
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        respondToTextFieldChange(textField)
        return true
    }
    
    private func respondToTextFieldChange(_ textField: UITextField) {
        guard
            let text = textField.text,
                !text.isEmpty
        else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            newName = nil
            return
        }
        navigationItem.rightBarButtonItem?.isEnabled = true
        newName = text
    }
}
