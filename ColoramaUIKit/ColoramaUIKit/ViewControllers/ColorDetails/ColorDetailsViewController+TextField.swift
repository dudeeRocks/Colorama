// Abstract: Delegate methods to handle text field events on details view as user types in the color name text field

import UIKit

extension ColorDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
