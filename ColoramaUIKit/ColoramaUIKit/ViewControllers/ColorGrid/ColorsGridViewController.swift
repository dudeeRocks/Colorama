// Abstract: View controller for colors grid.

import UIKit

class ColorsGridViewController: UICollectionViewController {
    
    let model: Model
    var dataSource: DataSource!
    
    // MARK: - Reusable Views Registration
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, Item>!
    var sectionHeaderRegistration: UICollectionView.SupplementaryRegistration<ColorGridSectionHeaderView>!
    var deleteButtonRegistration: UICollectionView.SupplementaryRegistration<ColorGridDeleteButtonView>!
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        registerReusableViews()
        connectDataSource()
        applySnapshot()
    }
    
    // MARK: - Initialization
    
    init(model: Model) {
        self.model = model
        super.init(collectionViewLayout: UICollectionViewLayout())
        
        view.backgroundColor = .systemGroupedBackground
        
        navigationItem.title = "Colors"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func editButtonTapped() {
        isEditing.toggle()
        print("isEditing: \(isEditing)")
    }
    
    // MARK: - Layout Configuration
    
    func configureLayout() {
        let spacing: CGFloat = 10
        let itemsPerRow: Int = 3
        
        let deleteButtonAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], absoluteOffset: CGPoint(x: 8, y: -8))
        let deleteButtonSize = NSCollectionLayoutSize(widthDimension: .absolute(32), heightDimension: .absolute(32))
        let deleteButton = NSCollectionLayoutSupplementaryItem(layoutSize: deleteButtonSize, elementKind: ElementKind.deleteButton.rawValue, containerAnchor: deleteButtonAnchor)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(itemsPerRow)), heightDimension: .estimated(10))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [deleteButton])
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(10))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(spacing)
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: ElementKind.header.rawValue, alignment: .topLeading)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing / 2, leading: spacing, bottom: spacing / 2, trailing: spacing)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }
}

