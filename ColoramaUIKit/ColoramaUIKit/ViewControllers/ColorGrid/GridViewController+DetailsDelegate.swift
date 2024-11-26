// Abstract: Methods to handle updates to color item from color details screen

import UIKit

extension GridViewController: ColorDetailsDelegate {
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

