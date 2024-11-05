// Abstract: View controller for colors grid.

import UIKit

private let reuseIdentifier = "Cell"

class ColorsGridViewController: UICollectionViewController {
    
    let model: Model
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Initialization
    
    init(model: Model) {
        self.model = model
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

