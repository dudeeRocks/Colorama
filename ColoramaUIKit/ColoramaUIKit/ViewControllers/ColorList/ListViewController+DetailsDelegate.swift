// Abstract: Methods to handle actions on details screen

import UIKit

extension ListViewController: ColorDetailsDelegate {
    func didAddNewColor(item: ColorItem) {
        model.addColor(item)
        applySnapshot(animated: true)
        configureRightBarButtonItem()
    }
    
    func didUpdateColor(item: ColorItem) {
        model.updateColor(item)
        applySnapshot()
    }
    
    func didRemoveColor(item: ColorItem) {
        model.removeColor(item)
        applySnapshot(animated: true)
        configureRightBarButtonItem()
    }
}
