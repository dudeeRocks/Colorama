// Abstract: Color grid methods for registering reusable views.

import UIKit

extension ColorsGridViewController {
    
    enum ElementKind: String, CaseIterable {
        case header, deleteButton
    }
    
    func registerReusableViews() {
        cellRegistration = .init(handler: cellRegistrationHandler)
        sectionHeaderRegistration = .init(elementKind: ElementKind.header.rawValue, handler: sectionHeaderRegistrationHandler)
        deleteButtonRegistration = .init(elementKind: ElementKind.deleteButton.rawValue, handler: deleteButtonRegisterationHandler)
    }
    
    private func cellRegistrationHandler(for cell: UICollectionViewCell, at indexPath: IndexPath, item: Item) {
        var contentConfiguration = cell.gridItemConfiguration()
        
        switch item {
        case .system(let colorItem), .custom(let colorItem):
            contentConfiguration.color = colorItem.color
            contentConfiguration.name = colorItem.name
        case .emptyState:
            contentConfiguration.color = .tertiarySystemBackground
            contentConfiguration.name = "No colors available"
        }

        cell.contentConfiguration = contentConfiguration
    }
    
    private func sectionHeaderRegistrationHandler(for header: ColorGridSectionHeaderView, elementKind: String, at indexPath: IndexPath) {
        let sectionTitle = dataSource.sectionIdentifier(for: indexPath.section)?.title
        header.text = sectionTitle
    }
    
    private func deleteButtonRegisterationHandler(for deleteButton: ColorGridDeleteButtonView, elementKind: String, at indexPath: IndexPath) {
        toggleDeleteButtonVisibility(deleteButton, at: indexPath)
    }
}

