// Abstract: data source logic for sort vc

import UIKit

extension SortViewController {
    func registerCells() {
        cellRegistration = .init(handler: cellRegistrationHandler)
    }
    
    func connectDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(shuffledColors)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func cellRegistrationHandler(for cell: UICollectionViewListCell, at indexPath: IndexPath, item: Item) {
        var background = cell.defaultBackgroundConfiguration()
        background.backgroundColor = item.colorItem?.color
        cell.backgroundConfiguration = background
    }
    
    
    private func cellProvider(for collectionView: UICollectionView, at indexPath: IndexPath, item: Item) -> UICollectionViewListCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
    }
}
