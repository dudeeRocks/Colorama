// Abstract: Extension to encapuslate diffable data source logic for colors grid VC.

import UIKit

extension ColorsGridViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    func registerCells() {
        cellRegistration = .init(handler: cellRegistrationHandler)
    }

    func connectDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.systemColors, .customColors])
        for systemColor in model.systemColors {
            snapshot.appendItems([.system(colorItem: systemColor)], toSection: .systemColors)
        }
        
        if model.customColors.isEmpty {
            snapshot.appendItems([.emptyState], toSection: .customColors)
        } else {
            for customColor in model.customColors {
                snapshot.appendItems([.custom(colorItem: customColor)], toSection: .customColors)
            }
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
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
    
    private func cellProvider(for collectionView: UICollectionView, at indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
    }

}
