// Abstract: List actions

import UIKit

extension ListViewController {
   
    enum Action: String, CaseIterable {
        case add = "Add"
        case edit = "Edit"
    }
    
    func handleOptionsMenuAction(_ action: UIAction) {
        if action.title == Action.add.rawValue {
            addColor()
        } else {
            toggleEditState()
        }
    }
    
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
    
    private func toggleEditState() {
        UIView.animate(.easeInOut) {
            isEditing.toggle()
        }
    }
}
