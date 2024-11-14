// Abstract: Color picker for editing color

import UIKit

extension ColorDetailsViewController: UIColorPickerViewControllerDelegate {
    func presentColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "Pick a color"
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .formSheet
        self.present(colorPicker, animated: true)
    }
    
    func colorPickerViewControllerDidFinish(_ colorPicker: UIColorPickerViewController) {
        let selectedColor = colorPicker.selectedColor
        
        newColor = selectedColor
        
        NotificationCenter.default.post(name: .colorChanged, object: nil, userInfo: [NSNotification.colorChanged: selectedColor])
    }
}

extension Notification.Name {
    static let colorChanged = Notification.Name("colorSelected")
}

extension NSNotification {
    static let colorChanged: String = "selectedColor"
}
