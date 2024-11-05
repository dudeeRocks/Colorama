// Abstract: Extension to encapuslate diffable data source logic for colors list VC.

import UIKit

extension ListViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    func connectDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: cellProvider)
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
    
    func delete(item: Item) {
        var updatedSnapshot = dataSource.snapshot()
        updatedSnapshot.deleteItems([item])
        dataSource.apply(updatedSnapshot, animatingDifferences: true)
    }
    
    // MARK: - Cell Provider
    
    private func cellProvider(for tableView: UITableView, at indexPath: IndexPath, item: Item) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
        
        switch item {
        case .system(let colorItem), .custom(colorItem: let colorItem):
            var content = cell.colorItemConfiguration()
            content.color = colorItem.color
            content.name = colorItem.name
            cell.contentConfiguration = content
        case .emptyState:
            var content = cell.defaultContentConfiguration()
            content.text = "No Colors"
            cell.contentConfiguration = content
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
