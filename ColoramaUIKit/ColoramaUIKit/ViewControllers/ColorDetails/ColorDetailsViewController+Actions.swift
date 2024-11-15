// Abstract: Actions for color details view controller

import UIKit

extension ColorDetailsViewController {
    @objc func editButtonTapped() {
        updateUI(for: .edit)
    }
    
    @objc func saveButtonTapped() {
        guard let newColor = newColor, let newName = newName else { return } // FIXME: This check prevents saving. Noodle on this
        colorItem.color = newColor
        colorItem.name = newName
        
        switch state {
        case .add:
            navigationController?.popViewController(animated: true)
            delegate.didAddNewColor(item: colorItem)
        default:
            updateUI(for: .view)
            delegate.didUpdateColor(item: colorItem)
        }
    }
    
    @objc func cancelButtonTapped() {
        switch state {
        case .edit: updateUI(for: .view)
        default: dismiss(animated: true)
        }
    }
    
    func deleteColor() {
        navigationController?.popViewController(animated: true)
        delegate.didRemoveColor(item: colorItem)
    }
}

protocol ColorDetailsDelegate {
    func didAddNewColor(item: ColorItem)
    func didUpdateColor(item: ColorItem)
    func didRemoveColor(item: ColorItem)
}
