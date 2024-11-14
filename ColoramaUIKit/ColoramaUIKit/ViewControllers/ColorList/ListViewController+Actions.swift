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
            addColor()
        } else {
            toggleEditState()
        }
    }
    
    // MARK: - Add Color
    
    private func addColor() {
        let newColor: ColorItem = .random
        let newItem: Item = .custom(colorItem: newColor)
        
        var updatedSnapshot = dataSource.snapshot()
        updatedSnapshot.appendItems([newItem], toSection: .customColors)
        dataSource.apply(updatedSnapshot)
        
        model.addColor(newColor)
        
        let detailsVC = ColorDetailsViewController(colorItem: newColor)
        
        let navigationVC = UINavigationController(rootViewController: detailsVC)
        present(navigationVC, animated: true)
    }
    
    // MARK: - Delete Color
    
    func delete(item: Item) {
        var updatedSnapshot = dataSource.snapshot()
        model.removeColor(item.colorItem!)
        updatedSnapshot.deleteItems([item])
        dataSource.apply(updatedSnapshot, animatingDifferences: true)
        
        if model.customColors.isEmpty {
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
