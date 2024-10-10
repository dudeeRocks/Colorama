// Abstract: Detaisl view for color

import SwiftUI

struct ColorDetailsView: View {
    
    @Binding var colorItem: ColorItem
    
    @State private var isFullscreen: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        if isFullscreen {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(colorItem.color)
                    .matchedGeometryEffect(id: colorItem.id, in: namespace, properties: .frame, anchor: .top, isSource: false)
                Text(colorItem.name)
                    .font(.largeTitle)
                    .foregroundStyle(.background)
                    .bold()
                    .matchedGeometryEffect(id: colorItem.name, in: namespace, properties: .position, anchor: .center, isSource: false)
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isFullscreen = false
                }
            }
        } else {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorItem.color)
                    .frame(height: 380)
                    .matchedGeometryEffect(id: colorItem.id, in: namespace, properties: .frame, anchor: .top, isSource: true)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isFullscreen = true
                        }
                    }
                Text(colorItem.name)
                    .font(.largeTitle)
                    .bold()
                    .matchedGeometryEffect(id: colorItem.name, in: namespace, properties: .position, anchor: .center, isSource: true)
                Spacer()
            }
            .padding()
        }
    }
}
