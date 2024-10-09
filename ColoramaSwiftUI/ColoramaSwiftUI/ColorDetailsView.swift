// Abstract: Detaisl view for color

import SwiftUI

struct ColorDetailsView: View {
    
    @Binding var color: ColorItem
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color.color)
                .frame(height: 380)
            Text(color.name)
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .padding()
    }
}
