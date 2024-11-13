// Abstract: View controller for colors list.

import UIKit

class ListViewController: UITableViewController {
    
    let model: Model
    var dataSource: DataSource!
    
    // MARK: - Reuse Identifiers
    
    let cellReuseIdentifier = "ListCell"
    let headerReuseIdentifier = "ListHeader"
    
    // MARK: - Initializers
    
    init(model: Model) {
        self.model = model
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        registerViews()
        connectDataSource()
        applySnapshot()
    }
    
    // MARK: - Methods
    
    private func configureNavigationBar() {
        let optionsMenu = UIMenu(children: [
            UIAction(title: Action.add.rawValue, image: UIImage(systemName: "plus"), handler: handleOptionsMenuAction),
            UIAction(title: Action.edit.rawValue, image: UIImage(systemName: "square.and.pencil"), handler: handleOptionsMenuAction)
        ])
        
        navigationItem.title = "Colors"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: optionsMenu)
    }
    
    private func registerViews() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
    }
}
