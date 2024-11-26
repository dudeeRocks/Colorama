// Abstract: A view controller that shuffles and sorts all colors in the model in an appealing way for demonstration purpose only.

import UIKit

class SortViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Item>
    
    let model: Model
    
    var timer: Timer!
    var shuffledColors: [Item] = []
    var currentIndex = 0
    
    var dataSource: DataSource!
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Item>!
    
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
        configureLayout()
        registerCells()
        connectDataSource()
        applySnapshot()
        Task {
            await sortColors()
        }
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
}
