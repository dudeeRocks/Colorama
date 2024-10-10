// Abstract: App's logic

import SwiftUI

class Model: ObservableObject {
    
    @Published var customColors: [ColorItem] = []
    private let customColorsKey: String = "customColors"
    
    let systemColors: [ColorItem] = [
        ColorItem(color: .red, name: "Red"),
        ColorItem(color: .orange, name: "Orange"),
        ColorItem(color: .yellow, name: "Yellow"),
        ColorItem(color: .green, name: "Green"),
        ColorItem(color: .teal, name: "Teal"),
        ColorItem(color: .cyan, name: "Cyan"),
        ColorItem(color: .blue, name: "Blue"),
        ColorItem(color: .purple, name: "Purple"),
        ColorItem(color: .pink, name: "Pink"),
        ColorItem(color: .brown, name: "Brown"),
        ColorItem(color: .primary, name: "Primary"),
        ColorItem(color: .secondary, name: "Secondary")
    ]
    
    // MARK: - Methods
    
    func addColor(_ color: ColorItem) {
        customColors.append(color)
        UserDefaults.standard.set(customColors, forKey: customColorsKey)
    }
    
    func removeColor(_ color: ColorItem) {
        customColors.removeAll(where: { $0.id == color.id })
        UserDefaults.standard.set(customColors, forKey: customColorsKey)
    }
    
    func updateColor(_ color: ColorItem) {
        if let index = customColors.firstIndex(where: { $0.id == color.id }) {
            customColors[index] = color
            UserDefaults.standard.set(customColors, forKey: customColorsKey)
        }
    }
    
    private func loadCustomColors() {
        let storedColors = UserDefaults.standard.array(forKey: customColorsKey) as? [ColorItem] ?? []
        customColors = storedColors
    }
    
    // MARK: - Initialization
    
    init() {
        loadCustomColors()
    }
}
