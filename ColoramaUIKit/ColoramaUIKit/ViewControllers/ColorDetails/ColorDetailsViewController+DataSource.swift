// Abstract: This data source manages the state of the detais screen: edit and view.

import UIKit

extension ColorDetailsViewController {
    enum DetailsSection: String, CaseIterable {
        case color
        case name
        case editColor
        case editName
        case deleteButton
    }
    
    enum DetailsRow: Hashable {
        case sectionHeader(title: String)
        case color(color: UIColor)
        case name(name: String)
        case editColor(color: UIColor)
        case editName(name: String)
        case deleteButton
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<DetailsSection, DetailsRow>
    typealias Snapshot = NSDiffableDataSourceSnapshot<DetailsSection, DetailsRow>
    
    func connectDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        
        switch state {
        case .view:
            snapshot.appendSections([.color, .name])
            snapshot.appendItems([.sectionHeader(title: DetailsSection.color.rawValue), .color(color: colorItem.color)], toSection: .color)
            snapshot.appendItems([.sectionHeader(title: DetailsSection.name.rawValue), .name(name: colorItem.name)], toSection: .name)
        case .add:
            snapshot.appendSections([.editColor, .editName])
            snapshot.appendItems([.sectionHeader(title: DetailsSection.color.rawValue), .editColor(color: colorItem.color)], toSection: .editColor)
            snapshot.appendItems([.sectionHeader(title: DetailsSection.name.rawValue), .editName(name: colorItem.name)], toSection: .editName)
        case .edit:
            snapshot.appendSections([.editColor, .editName, .deleteButton])
            snapshot.appendItems([.sectionHeader(title: DetailsSection.color.rawValue), .editColor(color: colorItem.color)], toSection: .editColor)
            snapshot.appendItems([.sectionHeader(title: DetailsSection.name.rawValue), .editName(name: colorItem.name)], toSection: .editName)
            snapshot.appendItems([.sectionHeader(title: ""), .deleteButton], toSection: .deleteButton)
        }
        
        dataSource.apply(snapshot)
    }
    
    private func cellProvider(for collectionView: UICollectionView, at indexPath: IndexPath, item: DetailsRow) -> UICollectionViewListCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
    }
    
}
