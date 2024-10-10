// Abstract: View controller for colors list.

import UIKit

class ColorsListViewController: UITableViewController {
    
    let model: Model
    
    // MARK: - Initializers
    
    init(model: Model) {
        self.model = model
        super.init(style: .grouped)
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
