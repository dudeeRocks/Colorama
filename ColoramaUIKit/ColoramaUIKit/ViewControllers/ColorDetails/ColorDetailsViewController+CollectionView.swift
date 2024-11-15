// Abstract: Methods for collection view for color details vc

import UIKit

extension ColorDetailsViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailsRow = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch detailsRow {
        case .color:
            return // TODO: Enlarge the color view?
        case .editColor:
            presentColorPicker()
        case .deleteButton:
            deleteColor()
            return
        default: return
        }
    }
}
