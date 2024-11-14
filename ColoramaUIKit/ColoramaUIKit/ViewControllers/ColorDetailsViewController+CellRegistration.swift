// Abstract: methods to handle cell registration for the collection view of the details screen

import UIKit

extension ColorDetailsViewController {
    func registerCell() {
        cellRegistration = .init(handler: cellRegistrationHandler)
    }
    
    private func cellRegistrationHandler(for cell: UICollectionViewListCell, at indexPath: IndexPath, item: SectionItem) {
        var contentConfiguration = cell.defaultContentConfiguration()
        
        switch item {
        case .sectionHeader(let title):
            if !title.isEmpty {
                contentConfiguration.text = title
            }
        case .color(let color):
            cell.backgroundColor = color
        case .name(let name):
            contentConfiguration.text = name
        case .deleteButton:
            contentConfiguration.text = "Delete"
            contentConfiguration.textProperties.color = .systemRed
        }
        
        cell.contentConfiguration = contentConfiguration
    }
}
