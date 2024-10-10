// Abstract: Color item definition

import SwiftUI

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
    
    static var newColor: Self {
        return ColorItem(color: .red, name: "New Color")
    }
}
