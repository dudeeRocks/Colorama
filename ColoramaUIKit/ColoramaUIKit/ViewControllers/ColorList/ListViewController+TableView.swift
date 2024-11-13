// Abstract: UITableViewDelegate methods for the ListViewController

import UIKit

extension ListViewController {
    
    // MARK: Section Headers
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier),
            let sectionTitle = dataSource.sectionIdentifier(for: section)?.title
        else {
            return nil
        }
        
        var configuration = headerView.defaultContentConfiguration()
        
        configuration.text = sectionTitle
        
        headerView.contentConfiguration = configuration
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    // MARK: - Row Selection
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let colorItem: ColorItem = dataSource.itemIdentifier(for: indexPath)?.colorItem else { return }
        
        let detailsVC = ColorDetailsViewController(colorItem: colorItem)
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: - Row Swipe Actions
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let item = dataSource.itemIdentifier(for: indexPath),
            dataSource.sectionIdentifier(for: indexPath.section) == .customColors,
            item != .emptyState
        else {
            return nil
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            self.delete(item: item)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard
            editingStyle == .delete,
            dataSource.sectionIdentifier(for: indexPath.section) == .customColors,
            let item = dataSource.itemIdentifier(for: indexPath),
            item != .emptyState
        else {
            return
        }
        delete(item: item)
    }
    
    // MARK: - Row Editing Style
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return dataSource.sectionIdentifier(for: indexPath.section) == .customColors && dataSource.itemIdentifier(for: indexPath) != .emptyState
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if dataSource.sectionIdentifier(for: indexPath.section) == .customColors && dataSource.itemIdentifier(for: indexPath) != .emptyState {
            return .delete
        } else {
            return .none
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return dataSource.sectionIdentifier(for: indexPath.section) == .customColors && dataSource.itemIdentifier(for: indexPath) != .emptyState
    }
}
