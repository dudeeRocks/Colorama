// Abstract: Methods for handling actions in grid view controller

import UIKit

extension ColorsGridViewController: ColorGridDeleteButtonViewDelegate {
    
    enum Action: String, CaseIterable {
        case add = "Add"
        case edit = "Edit"
    }
    
    func handleRightBarButtonAction(_ action: UIAction) {
        if action.title == Action.add.rawValue {
            presentAddColorScreen()
        } else {
            toggleEditState()
        }
    }
    
    func configureDeleteButton(_ deleteButton: ColorGridDeleteButtonView, at indexPath: IndexPath) {
        guard
            let item = dataSource.itemIdentifier(for: indexPath),
            dataSource.sectionIdentifier(for: indexPath.section) == .customColors
        else {
            deleteButton.isHidden = true
            return
        }
        deleteButton.delegate = self
        deleteButton.isHidden = !isEditing
        deleteButton.onTap = { [weak self] in self?.delete(item: item) }
    }
    
    // MARK: - Add Color
    
    private func presentAddColorScreen() {
        let detailsVC = ColorDetailsViewController(colorItem: .newColor, state: .add, delegate: self)
        
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
            configureLayout(animated: true)
            configureRightBarButtonItem()
        }
    }
    
    // MARK: - Toggle Edit State
    
    private func toggleEditState() {
        isEditing.toggle()
        collectionView.collectionViewLayout.invalidateLayout()
        configureRightBarButtonItem()
        
        for indexPath in collectionView.indexPathsForVisibleSupplementaryElements(ofKind: ElementKind.deleteButton.rawValue) {
            if let deleteButton = collectionView.supplementaryView(forElementKind: ElementKind.deleteButton.rawValue, at: indexPath) as? ColorGridDeleteButtonView {
                configureDeleteButton(deleteButton, at: indexPath)
            }
        }
    }
}
