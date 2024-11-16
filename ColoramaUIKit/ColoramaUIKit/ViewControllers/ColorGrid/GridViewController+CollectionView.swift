// Abstract: Methods to handle collection view delegate calls

import UIKit

extension GridViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let item = dataSource.itemIdentifier(for: indexPath),
            item != .emptyState
        else { return }
        
        let detailsVC = ColorDetailsViewController(item: item, state: .view, delegate: self)
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
