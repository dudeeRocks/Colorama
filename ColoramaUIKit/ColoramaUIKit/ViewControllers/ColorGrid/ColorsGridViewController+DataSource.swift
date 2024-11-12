// Abstract: Extension to encapuslate diffable data source logic for colors grid VC.

import UIKit

extension ColorsGridViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    func connectDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        dataSource.supplementaryViewProvider = supplementaryViewProvider
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
    
    private func cellProvider(for collectionView: UICollectionView, at indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
    }
    
    private func supplementaryViewProvider(for collectionView: UICollectionView, elementKind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if elementKind == ElementKind.header.rawValue {
            return collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)
        } else {
            return collectionView.dequeueConfiguredReusableSupplementary(using: deleteButtonRegistration, for: indexPath)
        }
    }

}
