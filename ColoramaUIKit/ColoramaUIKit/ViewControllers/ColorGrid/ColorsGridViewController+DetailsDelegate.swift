// Abstract: Methods to handle updates to color item from color details screen

import UIKit

extension ColorsGridViewController: ColorDetailsDelegate {
    func didAddNewColor(item: ColorItem) {
        //
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

