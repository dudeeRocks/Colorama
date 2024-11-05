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
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return nil }
        
        // Retrieve the section that contains the swiped item
        let snapshot = dataSource.snapshot()
        let sectionContainingSwipedItem = snapshot.sectionIdentifier(containingItem: item)
        
        // Check if item is in 'custom colors' section. Colors in 'system colors' section must not be deleted!
        guard sectionContainingSwipedItem == .customColors else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            self.delete(item: item)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
