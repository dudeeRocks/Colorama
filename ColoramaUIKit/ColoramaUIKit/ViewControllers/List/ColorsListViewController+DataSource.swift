// Abstract: Extension to encapuslate diffable data source logic for colors list VC.

import UIKit

extension ColorsListViewController {
    /// Even though you can simply use `Int` for sections, it really helps make more sense of the layout if you define your sections explicitly.
    /// Using `enum` in this case makes a lot of sense and is really straightforward since enumerations in Swift are conforming to `Hashable` by default.
    enum Section {
        case systemColors, customColors
        
        var title: String {
            switch self {
            case .systemColors: return "System Colors"
            case .customColors: return "Custom Colors"
            }
        }
    }
    
    /// Diffable data source has a crazy long name like those aristochrat dudes from back in the day, especially considering that you need to speicfy the generic parapmeters
    /// Using typealiases comes really in handy in this case.
    typealias DataSource = UITableViewDiffableDataSource<Section, ColorItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ColorItem>
    
    /// With type aliases set up for our data source and snapshot we can start using them in our code.
    /// First thing to do is to create the data source.
    func setupDataSource() {
        /// If you're planning on using custom UI for your table cells you need to register that design prior to creating a data source.
        /// For simple cases you can use the default configuration.
        /// For more complex cases you can create your own configurations.
        /// You can also create a cell in the storyboard or programmatically.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        /// I prefer declaring data sources as implicitly unwrapped optional at the top of my view controller, and set it up in a separate function on `init` or `viewDidLoad`.
        /// You create diffable data source for `UITableViewController` using dedicated `init(tableView:cellProvider:)` initializer that accepts the table view and a cell provider. Let's break those down.
        
        /// `tableView` – the table view to apply the data source to. Pass the `tableView` property of your `UITableViewController`.
        /// `cellProvider` – this is the closure where you deifne your cells. This closure comes with three parameters:
        ///     `tableView` and `indexPath` are used  to dequeue reusable cells. The former represents the table you;re configuring the cells for, and teh latter is the location of the item in the table for the cell.
        ///     `itemIdentifier` is the item you're defining the cell for. If you're using your custom type, this is it, and you get all the data for it to configure your cell.
        
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, colorItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
            
            /// There are several ways you can provide designs for your cells in a table
            /// For simple cases it's sufficient to generate a default config and simply customize it.
            /// You can also provide your custom views designed in storyboard and subclassing them to UITableViewCell
            /// However, the best way to provide custom UI for table cell programmatically is to use the UIContentView with it's UIContentConfiguration.
            var content = cell.colorItemConfiguration()
            content.color = colorItem.color
            content.name = colorItem.name
            cell.contentConfiguration = content
            return cell
        }
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.systemColors, .customColors])
        snapshot.appendItems(model.systemColors, toSection: .systemColors)
        snapshot.appendItems(model.customColors, toSection: .customColors)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
