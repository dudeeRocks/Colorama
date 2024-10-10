// Abstract: a view of a cell in the colors grid

import SwiftUI

struct ColorCellView: View {
    
    let color: ColorItem
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color.color)
                .stroke(.separator, lineWidth: 1)
                .frame(width: 100, height: 100)
            Text(color.name)
                .tint(.primary)
                .lineLimit(1)
        }
    }
}
