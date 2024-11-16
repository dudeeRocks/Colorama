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
        switch item {
        case .system(let colorItem), .custom(let colorItem):
            var gridItemConfiguration = cell.gridItemConfiguration()
            gridItemConfiguration.color = colorItem.color
            gridItemConfiguration.name = colorItem.name
            
            cell.contentConfiguration = gridItemConfiguration
        case .emptyState:
            var emptyStateConfiguration = cell.emptyStateConfiguration()
            emptyStateConfiguration.isGrid = true
            emptyStateConfiguration.target = self
            emptyStateConfiguration.action = #selector(presentAddColorScreen)
            cell.contentConfiguration = emptyStateConfiguration
        }
    }
    
    private func sectionHeaderRegistrationHandler(for header: ColorGridSectionHeaderView, elementKind: String, at indexPath: IndexPath) {
        let sectionTitle = dataSource.sectionIdentifier(for: indexPath.section)?.title
        header.text = sectionTitle
    }
    
    private func deleteButtonRegisterationHandler(for deleteButton: ColorGridDeleteButtonView, elementKind: String, at indexPath: IndexPath) {
        configureDeleteButton(deleteButton, at: indexPath)
    }
}

