// Abstract: View controller for colors grid.

import UIKit

class ColorsGridViewController: UICollectionViewController {
    
    let model: Model
    var dataSource: DataSource!
    
    // MARK: - Cell Registration
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, Item>!
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        registerCells()
        connectDataSource()
        applySnapshot()
    }
    
    // MARK: - Initialization
    
    init(model: Model) {
        self.model = model
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Configuration
    
    func configureLayout() {
        let spacing: CGFloat = 10
        let itemsPerRow: Int = 3
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(itemsPerRow)), heightDimension: .estimated(10))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(10))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing / 2, leading: spacing, bottom: spacing / 2, trailing: spacing)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }
}

