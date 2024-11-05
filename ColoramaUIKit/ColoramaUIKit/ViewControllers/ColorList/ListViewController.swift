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
        self.registerTableViewCellAndHeader()
        self.connectDataSource()
        self.applySnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Colors"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addColor))
    }
    
    private func registerTableViewCellAndHeader() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
    }
}
