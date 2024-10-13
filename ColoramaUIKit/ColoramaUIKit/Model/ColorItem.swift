// Abstract: Color item definition

import UIKit

struct ColorItem: Identifiable {
    let id: UUID = UUID()
    var name: String
    var red: Double
    var green: Double
    var blue: Double
    
    var color: UIColor {
        get {
            UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
        set {
            let colorComponents = newValue.getComponents()
            red = colorComponents[0]
            green = colorComponents[1]
            blue = colorComponents[2]
        }
    }
    
    init (color: UIColor, name: String) {
        let colorComponents = color.getComponents()
        red = colorComponents[0]
        green = colorComponents[1]
        blue = colorComponents[2]
        self.name = name
    }
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

extension ColorItem: Hashable {
    /// Whenever you want to use your custom type in diffable data source you must conform to `Hashable` protocol.
    /// This can beeasily achieved by generating `UUID` for your structure and use it to create has value.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ColorItem {
    enum CodingKeys: CodingKey {
        case name, red, green, blue
    }
}

extension ColorItem: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        red = try values.decode(Double.self, forKey: .red)
        green = try values.decode(Double.self, forKey: .green)
        blue = try values.decode(Double.self, forKey: .blue)
    }
}

extension ColorItem: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(red, forKey: .red)
        try container.encode(green, forKey: .green)
        try container.encode(blue, forKey: .blue)
    }
}

extension UIColor {
    func getComponents() -> [CGFloat] {
        if let components = self.cgColor.components {
            return components
        } else {
            print("Failed to get components for color.")
            return [0, 0, 0, 1]
        }
    }
}

