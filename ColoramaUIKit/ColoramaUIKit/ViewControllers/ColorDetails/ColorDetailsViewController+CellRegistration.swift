// Abstract: methods to handle cell registration for the collection view of the details screen

import UIKit

extension ColorDetailsViewController {
    func registerCell() {
        cellRegistration = .init(handler: cellRegistrationHandler)
    }
    
    private func cellRegistrationHandler(for cell: UICollectionViewListCell, at indexPath: IndexPath, item: DetailsRow) {        
        switch item {
        case .sectionHeader(let title):
            configureSectionHeader(for: cell, title: title)
        case .color(let color):
            configureColorView(for: cell, color: color)
        case .name(let name):
            configureNameView(for: cell, name: name)
        case .editColor(let color):
            configureColorPickerView(for: cell, color: color)
        case .editName(let name):
            configureNameTextFieldView(for: cell, text: name, delegate: self)
        case .deleteButton:
            configureDeleteButton(for: cell)
        }
    }
    
    private func configureSectionHeader(for cell: UICollectionViewListCell, title: String) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title.isEmpty ? nil : title
        cell.contentConfiguration = contentConfiguration
    }
    
    private func configureColorView(for cell: UICollectionViewListCell, color: UIColor) {
        var contentConfiguration = ColorView.Configuration()
        contentConfiguration.color = color
        cell.contentConfiguration = contentConfiguration
    }
    
    private func configureColorPickerView(for cell: UICollectionViewListCell, color: UIColor) {
        var contentConfiguration = ColorPickerView.Configuration()
        contentConfiguration.color = color
        cell.contentConfiguration = contentConfiguration
    }
    
    private func configureNameView(for cell: UICollectionViewListCell, name: String) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = name
        cell.contentConfiguration = contentConfiguration
    }
    
    private func configureNameTextFieldView(for cell: UICollectionViewListCell, text: String, delegate: UITextFieldDelegate) {
        var contentConfiguration = ColorNameTextFieldView.Configuration()
        contentConfiguration.text = text
        contentConfiguration.delegate = delegate
        cell.contentConfiguration = contentConfiguration
    }
    
    private func configureDeleteButton(for cell: UICollectionViewListCell) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = "Delete"
        contentConfiguration.textProperties.color = .systemRed
        cell.contentConfiguration = contentConfiguration
    }
}
