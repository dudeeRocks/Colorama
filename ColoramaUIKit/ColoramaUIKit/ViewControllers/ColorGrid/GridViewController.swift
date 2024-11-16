// Abstract: View controller for colors grid.

import UIKit

class GridViewController: UICollectionViewController {
    
    let model: Model
    var dataSource: DataSource!
    
    // MARK: - Reusable Views Registration
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, Item>!
    var sectionHeaderRegistration: UICollectionView.SupplementaryRegistration<ColorGridSectionHeaderView>!
    var deleteButtonRegistration: UICollectionView.SupplementaryRegistration<ColorGridDeleteButtonView>!
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        configureNavigationBar()
        configureLayout()
        registerReusableViews()
        connectDataSource()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        applySnapshot()
        configureRightBarButtonItem()
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
    
    func configureLayout(animated: Bool = false) {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, collectionLayoutEnvironment in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            let spacing: CGFloat = 20
            let itemsPerRow: Int = 3
            
            if sectionKind == .customColors {
                if self.model.customColors.isEmpty {
                    let emptyStateItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                    let emptyStateItem = NSCollectionLayoutItem(layoutSize: emptyStateItemSize)
                    
                    let emptyStateGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
                    let emptyStateGroup = NSCollectionLayoutGroup.vertical(layoutSize: emptyStateGroupSize, subitems: [emptyStateItem])
                    emptyStateGroup.interItemSpacing = .fixed(0)
                    
                    section = NSCollectionLayoutSection(group: emptyStateGroup)
                } else {
                    let deleteButtonAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], absoluteOffset: CGPoint(x: 8, y: -8))
                    let deleteButtonSize = NSCollectionLayoutSize(widthDimension: .absolute(32), heightDimension: .absolute(32))
                    let deleteButton = NSCollectionLayoutSupplementaryItem(layoutSize: deleteButtonSize, elementKind: ElementKind.deleteButton.rawValue, containerAnchor: deleteButtonAnchor)
                    
                    let customColorsItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(itemsPerRow)), heightDimension: .estimated(10))
                    let customColorsItem = NSCollectionLayoutItem(layoutSize: customColorsItemSize, supplementaryItems: [deleteButton])
                    
                    let customColorsGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                    let customColorsGroup = NSCollectionLayoutGroup.horizontal(layoutSize: customColorsGroupSize, subitems: [customColorsItem])
                    customColorsGroup.interItemSpacing = .flexible(spacing)
                    
                    section = NSCollectionLayoutSection(group: customColorsGroup)
                }
            } else {
                let systemColorsItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(itemsPerRow)), heightDimension: .estimated(10))
                let systemColorsItem = NSCollectionLayoutItem(layoutSize: systemColorsItemSize)
                
                let systemColorsGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                let systemColorsGroup = NSCollectionLayoutGroup.horizontal(layoutSize: systemColorsGroupSize, subitems: [systemColorsItem])
                systemColorsGroup.interItemSpacing = .flexible(spacing)
                
                section = NSCollectionLayoutSection(group: systemColorsGroup)
            }
            
            let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: ElementKind.header.rawValue, alignment: .topLeading)
            
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: spacing * 2, trailing: spacing)
            section.boundarySupplementaryItems = [sectionHeader]
            print("returning section for \(sectionKind.title)")
            return section
        }
        collectionView.setCollectionViewLayout(layout, animated: animated)
    }
    
    // MARK: - Navigation Bar
    
    func configureNavigationBar() {
        navigationItem.title = "Colors"
        navigationItem.largeTitleDisplayMode = .automatic
        configureRightBarButtonItem()
    }
    
    func configureRightBarButtonItem() {
        if isEditing {
            let doneButton = UIBarButtonItem(systemItem: .done, primaryAction: UIAction(title: Action.edit.rawValue, handler: handleRightBarButtonAction))
            navigationItem.rightBarButtonItem = doneButton
            navigationItem.rightBarButtonItem?.menu = nil
        } else {
            let optionsButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"))
            let isEditButtonDisabled: Bool = model.customColors.isEmpty
            let optionsMenu = UIMenu(children: [
                UIAction(
                    title: Action.add.rawValue,
                    image: UIImage(systemName: "plus"),
                    handler: handleRightBarButtonAction),
                UIAction(
                    title: Action.edit.rawValue,
                    image: UIImage(systemName: "square.and.pencil"),
                    attributes: isEditButtonDisabled ? [.disabled] : [],
                    handler: handleRightBarButtonAction)
            ])
            navigationItem.rightBarButtonItem = optionsButton
            navigationItem.rightBarButtonItem?.menu = optionsMenu
        }
    }
}

