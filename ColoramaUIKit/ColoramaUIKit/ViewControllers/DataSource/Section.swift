// Abstract: Object that represents sections of list/grid.

import UIKit

enum Section {
    case systemColors, customColors
    
    var title: String {
        switch self {
        case .systemColors: return "System Colors"
        case .customColors: return "Custom Colors"
        }
    }
}
