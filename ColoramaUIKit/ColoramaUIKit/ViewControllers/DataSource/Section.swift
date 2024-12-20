// Abstract: Object that represents sections of list/grid.

import UIKit

enum Section: Int, CaseIterable {
    case customColors, systemColors
    
    var title: String {
        switch self {
        case .systemColors: return "System Colors"
        case .customColors: return "Custom Colors"
        }
    }
}
