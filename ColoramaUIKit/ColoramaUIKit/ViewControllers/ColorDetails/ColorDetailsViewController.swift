// Abstract: View for the color details.

import UIKit

class ColorDetailsViewController: UICollectionViewController {
    
    enum State { case view, edit, add }

    var colorItem: ColorItem
    var state: State
    
    var newColor: UIColor?
    var newName: String?
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, DetailsRow>!
    var dataSource: DataSource!
    
    // MARK: - Initialization
    
    init(colorItem: ColorItem, state: State) {
        self.colorItem = colorItem
        self.state = state
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLayout()
        registerCell()
        connectDataSource()
        applySnapshot()
    }
    
    // MARK: - Methods
    
    func updateUI(for state: State) {
        self.state = state
        configureNavigationBar()
        applySnapshot()
    }
    
    // MARK: Layout
    
    func configureLayout() {
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfiguration.headerMode = .firstItemInSection
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
    }
    
    // MARK: Navigation Bar
    
    func configureNavigationBar() {
        switch state {
        case .view:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
            navigationItem.leftBarButtonItem = nil
        case .edit:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        case .add:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addButtonTapped))
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        }
    }
}
