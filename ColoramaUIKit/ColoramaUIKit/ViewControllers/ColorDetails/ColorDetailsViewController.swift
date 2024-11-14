// Abstract: View for the color details.

import UIKit

class ColorDetailsViewController: UICollectionViewController {
    
    enum State { case view, edit, add }

    var colorItem: ColorItem
    var state: State
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, DetailsRow>!
    var dataSource: DataSource!
    
    init(colorItem: ColorItem, state: State) {
        self.colorItem = colorItem
        self.state = state
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLayout()
        registerCell()
        connectDataSource()
        applySnapshot()
    }
    
    func configureLayout() {
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfiguration.headerMode = .firstItemInSection
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
    }
    
    func configureNavigationBar() {
        switch state {
        case .view:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        case .edit:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        case .add:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        }
    }
    
    func updateUI(for state: State) {
        self.state = state
        configureNavigationBar()
        applySnapshot()
    }
}
