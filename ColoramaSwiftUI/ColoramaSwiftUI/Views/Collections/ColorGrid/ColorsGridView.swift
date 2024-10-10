// Abstract: colors grid view

import SwiftUI

struct ColorsGridView: View {
    
    @EnvironmentObject var model: Model
    
    @State var isSheetPresented: Bool = false
    
    private let columns: [GridItem] = .init(repeating: GridItem(.adaptive(minimum: 80, maximum: 120), spacing: 20), count: 3)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("System Colors".uppercased())
                    .gridSectionHeader()
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(model.systemColors) { color in
                        NavigationLink {
                            ColorView(colorItem: Binding(get: { color }, set: { _ in }), isSystemColor: true)
                        } label: {
                            ColorCellView(color: color)
                        }
                    }
                }
                .padding([.horizontal, .bottom], 16)
                
                Text("Custom Colors".uppercased())
                    .gridSectionHeader()
                
                if model.customColors.isEmpty {
                    EmptyStateView(isPresented: $isSheetPresented)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.background)
                        }
                        .padding([.horizontal, .bottom], 20)
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach($model.customColors) { color in
                            NavigationLink {
                                ColorView(colorItem: color)
                            } label: {
                                ColorCellView(color: color.wrappedValue)
                            }
                        }
                    }
                    .padding([.horizontal, .bottom], 16)
                }
            }
            .colorsNavigationTitle(isSheetPresented: $isSheetPresented)
            .background(.gray.opacity(0.15))
        }
    }
}

extension Text {
    func gridSectionHeader() -> some View {
        self
            .font(.footnote)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 40)
            .padding(.top, 20)
    }
}

#Preview {
    ColorsGridView()
        .environmentObject(Model())
}
