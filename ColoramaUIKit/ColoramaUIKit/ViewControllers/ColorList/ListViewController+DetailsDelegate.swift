// Abstract: Methods to handle actions on details screen

import UIKit

extension ListViewController: ColorDetailsDelegate {
    func didAddNewColor(item: ColorItem) {
        model.addColor(item)
        applySnapshot(true)
    }
    
    func didUpdateColor(item: ColorItem) {
        model.updateColor(item)
        applySnapshot()
    }
    
    func didRemoveColor(item: ColorItem) {
        model.removeColor(item)
        applySnapshot(true)
    }
}
