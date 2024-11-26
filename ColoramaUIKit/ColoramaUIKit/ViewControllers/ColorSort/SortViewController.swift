// Abstract: A view controller that shuffles and sorts all colors in the model in an appealing way for demonstration purpose only.

import UIKit

class SortViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Item>
    
    let model: Model
    
    var shuffledColors: [Item] = []
    var currentIndex = 0
    
    var dataSource: DataSource!
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Item>!
    
    var sortTask: Task<Void, Never>?
    var isSorting: Bool = false
    
    init(model: Model) {
        self.model = model
        super.init(collectionViewLayout: UICollectionViewLayout())
        self.shuffledColors = createShuffledColorsArray()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLayout()
        registerCells()
        connectDataSource()
        applySnapshot()
        sortColors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sortTask?.cancel()
        sortTask = nil
        shuffledColors = createShuffledColorsArray()
        applySnapshot()
        configureNavigationBar()
    }
    
    private func configureLayout() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.headerMode = .none
        configuration.showsSeparators = false
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func createShuffledColorsArray() -> [Item] {
        var array: [Item] = []
        
        for color in model.customColors {
            array.append(.custom(colorItem: color))
        }
        
        for color in model.systemColors {
            array.append(.system(colorItem: color))
        }
        
        return array.shuffled()
    }
    
    // MARK: - Navigation Bar
    
    func configureNavigationBar() {
        navigationItem.title = "Colors"
        navigationItem.largeTitleDisplayMode = .automatic
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector (sortColors))
        navigationItem.rightBarButtonItem?.isEnabled = !isSorting
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector (shuffleColors))
    }
}
