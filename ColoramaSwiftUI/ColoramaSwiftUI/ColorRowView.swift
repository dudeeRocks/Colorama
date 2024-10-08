// Abstract: List row view

import SwiftUI

struct ColorRowView: View {
    
    let color: ColorItem
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color.color)
                .stroke(.separator, lineWidth: 1)
                .frame(width: 30, height: 30)
            Text(color.name)
        }
    }
}
