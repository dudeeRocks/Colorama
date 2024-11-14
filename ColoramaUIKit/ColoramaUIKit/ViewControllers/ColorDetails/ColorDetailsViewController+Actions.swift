// Abstract: Actions for color details view controller

import UIKit

extension ColorDetailsViewController {
    @objc func editButtonTapped() {
        updateUI(for: .edit)
    }
    
    @objc func saveButtonTapped() {
        updateUI(for: .view)
    }
    
    @objc func addButtonTapped() {
        
    }
    
    @objc func cancelButtonTapped() {
        switch state {
        case .edit: updateUI(for: .view)
        default: dismiss(animated: true)
        }
    }
}
