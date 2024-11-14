// Abstract: View for the color details.

import UIKit

class ColorDetailsViewController: UICollectionViewController {
    
    enum DetailsViewState { case view, edit, add }

    var colorItem: ColorItem
    var state: DetailsViewState
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, SectionItem>!
    var dataSource: DataSource!
    
    init(colorItem: ColorItem, state: DetailsViewState) {
        self.colorItem = colorItem
        self.state = state
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
