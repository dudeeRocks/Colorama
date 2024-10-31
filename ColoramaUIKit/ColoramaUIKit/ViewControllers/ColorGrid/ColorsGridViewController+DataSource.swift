// Abstract: Extension to encapuslate diffable data source logic for colors grid VC.

import UIKit

extension ColorsGridViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
}
