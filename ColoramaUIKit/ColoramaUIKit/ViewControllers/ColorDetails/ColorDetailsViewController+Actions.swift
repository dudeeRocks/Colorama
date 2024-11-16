// Abstract: Actions for color details view controller

import UIKit

extension ColorDetailsViewController {
    @objc func editButtonTapped() {
        updateUI(for: .edit)
    }
    
    @objc func saveButtonTapped() {
        if let newColor = newColor {
            colorItem.color = newColor
        }
        
        if let newName = newName {
            colorItem.name = newName
        }
        
        switch state {
        case .add:
            dismiss(animated: true) { [unowned self] in
                delegate.didAddNewColor(item: colorItem)
            }
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
