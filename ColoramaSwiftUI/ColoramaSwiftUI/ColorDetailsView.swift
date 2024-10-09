// Abstract: Detaisl view for color

import SwiftUI

struct ColorDetailsView: View {
    
    @Binding var color: ColorItem
    
    @State private var isFullscreen: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        if isFullscreen {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(color.color)
                    .matchedGeometryEffect(id: color.id, in: namespace, properties: .frame, anchor: .top, isSource: false)
                Text(color.name)
                    .font(.largeTitle)
                    .foregroundStyle(.background)
                    .bold()
                    .matchedGeometryEffect(id: color.name, in: namespace, properties: .position, anchor: .center, isSource: false)
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isFullscreen = false
                }
            }
        } else {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(color.color)
                    .frame(height: 380)
                    .matchedGeometryEffect(id: color.id, in: namespace, properties: .frame, anchor: .top, isSource: true)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isFullscreen = true
                        }
                    }
                Text(color.name)
                    .font(.largeTitle)
                    .bold()
                    .matchedGeometryEffect(id: color.name, in: namespace, properties: .position, anchor: .center, isSource: true)
                Spacer()
            }
            .padding()
        }
    }
}
