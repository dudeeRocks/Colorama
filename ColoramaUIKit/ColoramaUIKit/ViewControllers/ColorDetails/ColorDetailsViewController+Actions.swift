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
}
