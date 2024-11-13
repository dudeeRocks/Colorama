// Abstract: Extension to encapuslate diffable data source logic for colors list VC.

import UIKit

extension ListViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    func connectDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: cellProvider)
    }
    
    func applySnapshot(_ animated: Bool = false) {
        guard dataSource != nil else { return }
        
        var snapshot = Snapshot()
        
        snapshot.appendSections([.customColors, .systemColors])
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
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    // MARK: - Cell Provider
    
    private func cellProvider(for tableView: UITableView, at indexPath: IndexPath, item: Item) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
        
        switch item {
        case .system(let colorItem), .custom(colorItem: let colorItem):
            var listItemConfiguration = cell.listItemConfiguration()
            listItemConfiguration.color = colorItem.color
            listItemConfiguration.name = colorItem.name
            cell.contentConfiguration = listItemConfiguration
        case .emptyState:
            var emptyStateConfiguration = cell.emptyStateConfiguration()
            cell.contentConfiguration = emptyStateConfiguration
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
