// Abstract: Methods for handling actions in grid view controller

import UIKit

extension ColorsGridViewController {
    
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
        isEditing.toggle()
        collectionView.collectionViewLayout.invalidateLayout()
        
        for indexPath in collectionView.indexPathsForVisibleSupplementaryElements(ofKind: ElementKind.deleteButton.rawValue) {
            if let deleteButton = collectionView.supplementaryView(forElementKind: ElementKind.deleteButton.rawValue, at: indexPath) as? ColorGridDeleteButtonView {
                deleteButton.isHidden = !isEditing
            }
        }
    }
}

