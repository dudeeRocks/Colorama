// Abstract: App's logic

import SwiftUI

class Model: ObservableObject {
    @Published var customColors: [ColorItem] = []
    
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
}

struct ColorItem: Identifiable {
    let id: UUID = UUID()
    var color: Color
    var name: String
}

extension ColorItem {
    static var random: Self {
        let model = Model()
        return model.systemColors.randomElement()!
    }
}
