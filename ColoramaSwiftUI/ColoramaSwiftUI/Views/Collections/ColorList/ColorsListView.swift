// Abstract: Colors list view

import SwiftUI

struct ColorsListView: View {
    
    @EnvironmentObject var model: Model
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("System Colors")) {
                    ForEach(model.systemColors) { color in
                        NavigationLink {
                            ColorView(colorItem: Binding(get: { color }, set: { _ in }), isSystemColor: true)
                        } label: {
                            ColorRowView(color: color)
                        }
                    }
                }
                
                
                Section(header: Text("Custom Colors")) {
                    if model.customColors.isEmpty {
                        EmptyStateView(isPresented: $isSheetPresented)
                    } else {
                        ForEach($model.customColors) { color in
                            NavigationLink {
                                ColorView(colorItem: color)
                            } label: {
                                ColorRowView(color: color.wrappedValue)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                                Button("Delete", systemImage: "trash", role: .destructive) {
                                    model.removeColor(color.wrappedValue)
                                }
                            })
                        }
                    }
                }
            }
            .colorsNavigationTitle(isSheetPresented: $isSheetPresented)
        }
    }
}
