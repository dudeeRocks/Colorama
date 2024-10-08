// Abstract: Detaisl view for color

import SwiftUI

struct ColorDetailsView: View {
    
    @Binding var color: ColorItem
    let namespace: Namespace.ID
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color.color)
                .frame(width: .infinity, height: (380))
                .matchedGeometryEffect(id: color.id, in: namespace, properties: .frame, anchor: .top)
            Text(color.name)
                .font(.largeTitle)
            Spacer()
        }
        .padding()
    }
}
