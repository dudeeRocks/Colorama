// Abstract: List actions

import UIKit

extension ListViewController {
   
    enum Action: String, CaseIterable {
        case add = "Add"
        case edit = "Edit"
    }
    
    // MARK: Menu Actions Handler
    
    func handleRightBarButtonAction(_ action: UIAction) {
        if action.title == Action.add.rawValue {
            presentAddColorScreen()
        } else {
            toggleEditState()
        }
    }
    
    // MARK: - Add Color
    
    @objc func presentAddColorScreen() {
        let detailsVC = ColorDetailsViewController(item: .custom(colorItem: .newColor), state: .add, delegate: self)
        
        let navigationVC = UINavigationController(rootViewController: detailsVC)
        present(navigationVC, animated: true)
    }
    
    // MARK: - Delete Color
    
    func delete(item: Item) {
        model.removeColor(item.colorItem!)
        applySnapshot(true)
        
        if model.customColors.isEmpty {
            isEditing = false
            configureRightBarButtonItem()
        }
    }
    
    // MARK: - Toggle Edit State
    
    private func toggleEditState() {
        UIView.animate(.easeInOut) {
            isEditing.toggle()
            configureRightBarButtonItem()
        }
    }
}
