// Abstract: This data source manages the state of the detais screen: edit and view.

import UIKit

extension ColorDetailsViewController {
    enum SectionHeader: String, CaseIterable {
        case color, name, deleteButton
    }
    
    enum SectionItem: Hashable {
        case sectionHeader(title: String)
        case color(color: UIColor)
        case name(name: String)
        case deleteButton
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<SectionHeader, SectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionHeader, SectionItem>
    
    func connectDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    func applySnapshot() {
        // 1. Create empty snapshot
        var snapshot = Snapshot()
        
        switch state {
        case .view, .add:
            snapshot.appendSections([.color, .name])
            snapshot.appendItems([.sectionHeader(title: SectionHeader.color.rawValue), .color(color: colorItem.color)], toSection: .color)
            snapshot.appendItems([.sectionHeader(title: SectionHeader.name.rawValue), .name(name: colorItem.name)], toSection: .name)
        case .edit:
            snapshot.appendSections([.color, .name, .deleteButton])
            snapshot.appendItems([.sectionHeader(title: SectionHeader.color.rawValue), .color(color: colorItem.color)], toSection: .color)
            snapshot.appendItems([.sectionHeader(title: SectionHeader.name.rawValue), .name(name: colorItem.name)], toSection: .name)
            snapshot.appendItems([.sectionHeader(title: ""), .deleteButton], toSection: .deleteButton)
        }
        
        dataSource.apply(snapshot)
    }
    
    private func cellProvider(for collectionView: UICollectionView, at indexPath: IndexPath, item: SectionItem) -> UICollectionViewListCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
    }
    
}
