// Abstract: Extension to encapuslate diffable data source logic for colors list VC.

import UIKit

extension ListViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    /// With type aliases set up for our data source and snapshot we can start using them in our code.
    /// First thing to do is to create the data source.
    func setupDataSource() {
        /// When creating the view for cells programmatically you need to register your cell first.
        /// If you're using the storyboard to design your cells, then you don't need to register the cells here, instead pass the cell reuse identifier when you dequeue the cells later.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        /// I prefer declaring data sources as implicitly unwrapped optional at the top of my view controller, and set it up in a separate function on `init` or `viewDidLoad`.
        /// You create diffable data source for `UITableViewController` using dedicated `init(tableView:cellProvider:)` initializer that accepts the table view and a cell provider. Let's break those down.
        
        /// `tableView` – the table view to apply the data source to. Pass the `tableView` property of your `UITableViewController`.
        /// `cellProvider` – this is the closure where you deifne your cells. This closure comes with three parameters:
        ///     `tableView` and `indexPath` are used  to dequeue reusable cells. The former represents the table you;re configuring the cells for, and teh latter is the location of the item in the table for the cell.
        ///     `itemIdentifier` is the item you're defining the cell for. If you're using your custom type, this is it, and you get all the data for it to configure your cell.
        
        dataSource = DataSource(tableView: tableView) { (tableView: UITableView, indexPath: IndexPath, item: Item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
            
            /// There are several ways you can provide designs for your cells in a table
            /// For simple cases it's sufficient to generate a default config and simply customize it.
            /// You can also provide your custom views designed in storyboard and subclassing them to UITableViewCell
            /// However, the best way to provide custom UI for table cell programmatically is to use the UIContentView with it's UIContentConfiguration.
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
            return cell
        }
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
}
