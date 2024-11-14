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
    
    override func viewWillAppear(_ animated: Bool) {
        applySnapshot()
        configureRightBarButtonItem()
    }
    
    // MARK: - Navigation Bar
    
    private func configureNavigationBar() {
        navigationItem.title = "Colors"
        navigationItem.largeTitleDisplayMode = .automatic
        configureRightBarButtonItem()
    }
    
    func configureRightBarButtonItem() {
        if isEditing {
            let doneButton = UIBarButtonItem(systemItem: .done, primaryAction: UIAction(title: Action.edit.rawValue, handler: handleRightBarButtonAction))
            navigationItem.rightBarButtonItem = doneButton
            navigationItem.rightBarButtonItem?.menu = nil
        } else {
            let optionsButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"))
            let isEditButtonDisabled: Bool = model.customColors.isEmpty
            let optionsMenu = UIMenu(children: [
                UIAction(
                    title: Action.add.rawValue,
                    image: UIImage(systemName: "plus"),
                    handler: handleRightBarButtonAction),
                UIAction(
                    title: Action.edit.rawValue,
                    image: UIImage(systemName: "square.and.pencil"),
                    attributes: isEditButtonDisabled ? [.disabled] : [],
                    handler: handleRightBarButtonAction)
            ])
            navigationItem.rightBarButtonItem = optionsButton
            navigationItem.rightBarButtonItem?.menu = optionsMenu
        }
    }
    
    // MARK: - View Registration
    
    private func registerViews() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
    }
}
