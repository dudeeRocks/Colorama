// Abstract: object representing item in colors list/grid, or empty state if necessary.

import Foundation

enum Item: Hashable {
    case system(colorItem: ColorItem)
    case custom(colorItem: ColorItem)
    case emptyState
    
    var colorItem: ColorItem? {
        switch self {
        case .system(colorItem: let colorItem): return colorItem
        case .custom(colorItem: let colorItem): return colorItem
        case .emptyState: return nil
        }
    }
}
