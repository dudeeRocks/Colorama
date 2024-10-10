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
        saveCustomColors()
    }
    
    func removeColor(_ color: ColorItem) {
        customColors.removeAll(where: { $0.id == color.id })
        saveCustomColors()
    }
    
    func updateColor(_ color: ColorItem) {
        if let index = customColors.firstIndex(where: { $0.id == color.id }) {
            customColors[index] = color
            saveCustomColors()
        }
    }
    
    private func saveCustomColors() {
        if let encodedColors = try? JSONEncoder().encode(customColors) {
            UserDefaults.standard.set(encodedColors, forKey: customColorsKey)
        }
    }
    
    private func loadCustomColors() {
        if let saveData = UserDefaults.standard.data(forKey: customColorsKey),
           let decodedColors = try? JSONDecoder().decode([ColorItem].self, from: saveData) {
            customColors = decodedColors
        }
    }
    
    // MARK: - Initialization
    
    init() {
        loadCustomColors()
    }
}
