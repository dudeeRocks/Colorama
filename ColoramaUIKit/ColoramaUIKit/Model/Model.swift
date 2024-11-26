// Abstract: App's logic

import UIKit

class Model {
    
    var customColors: [ColorItem] = []
    private let customColorsKey: String = "customColors"
    
    let systemColors: [ColorItem] = [
        ColorItem(color: .systemRed, name: "Red"),
        ColorItem(color: .systemOrange, name: "Orange"),
        ColorItem(color: .systemYellow, name: "Yellow"),
        ColorItem(color: .systemGreen, name: "Green"),
        ColorItem(color: .systemMint, name: "Mint"),
        ColorItem(color: .systemTeal, name: "Teal"),
        ColorItem(color: .systemCyan, name: "Cyan"),
        ColorItem(color: .systemBlue, name: "Blue"),
        ColorItem(color: .systemIndigo, name: "Indigo"),
        ColorItem(color: .systemPurple, name: "Purple"),
        ColorItem(color: .systemPink, name: "Pink"),
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
