// Abstract: View controller for colors list.

import UIKit

class ListViewController: UITableViewController {
    
    let model: Model
    var dataSource: DataSource!
    /// To generate cells you need a reuse id
    let cellReuseIdentifier = "ColorCell"
    
    // MARK: - Initializers
    
    init(model: Model) {
        self.model = model
        super.init(style: .insetGrouped)
        self.setupDataSource()
        self.applySnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Colors"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addColor))
    }
}
