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
    
    private func configureLayout(isGrid: Bool = false, animated: Bool = false) {
        let layout: UICollectionViewLayout
        if isGrid {
            let spacing: CGFloat = 0
            let itemsPerRow: Int = 3
            let rowsOnScreen: Int = shuffledColors.count / itemsPerRow
            
            let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1 / CGFloat(itemsPerRow)), heightDimension: .fractionalHeight(1))
            let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
            
            let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / CGFloat(rowsOnScreen)))
            let group: NSCollectionLayoutGroup = .horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(spacing)
            
            let section: NSCollectionLayoutSection = .init(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            
            layout = UICollectionViewCompositionalLayout(section: section)
        } else {
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.headerMode = .none
            configuration.showsSeparators = false
            layout = UICollectionViewCompositionalLayout.list(using: configuration)
        }
        collectionView.setCollectionViewLayout(layout, animated: animated)
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
        let segmentedControl = UISegmentedControl(items: [Layout.list.title, Layout.grid.title])
        segmentedControl.addTarget(self, action: #selector (changeLayout), for: .valueChanged)
        navigationItem.titleView = segmentedControl
        navigationItem.largeTitleDisplayMode = .automatic
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector (sortColors))
        navigationItem.rightBarButtonItem?.isEnabled = !isSorting
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector (shuffleColors))
    }
    
    @objc func changeLayout(_ sender: UISegmentedControl) {
        sortTask?.cancel()
        sortTask = nil
        if sender.selectedSegmentIndex == Layout.list.rawValue {
            configureLayout(isGrid: false, animated: true)
        } else {
            configureLayout(isGrid: true, animated: true)
        }
    }
    
    enum Layout: Int {
        case list, grid
        var title: String {
            switch self {
            case .list: return "List"
            case .grid: return "Grid"
            }
        }
    }
}
