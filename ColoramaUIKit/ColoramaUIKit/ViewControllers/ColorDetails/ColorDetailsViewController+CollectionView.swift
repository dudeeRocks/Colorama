// Abstract: Methods for collection view for color details vc

import UIKit

extension ColorDetailsViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailsRow = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch detailsRow {
        case .color(let color):
            return // TODO: Enlarge the color view?
        case .editColor(let color):
            presentColorPicker()
        case .editName(let name):
            return // TODO: Focus the text field
        case .deleteButton:
            return // TODO: Trigger delete confirm alert
        default: return
        }
    }
}
