// Abstract: Colors list view

import SwiftUI

struct ColorsListView: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("System Colors")) {
                    ForEach(model.systemColors) { color in
                        NavigationLink {
                            ColorDetailsView(color: Binding(get: { color }, set: { _ in }))
                                .navigationTitle(color.name)
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            ColorRowView(color: color)
                        }
                    }
                }
                
                Section(header: Text("Custom Colors")) {
                    ForEach(model.customColors) { color in
                        NavigationLink {
                            ColorDetailsView(color: Binding(get: { color }, set: { _ in }))
                                .navigationTitle(color.name)
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            ColorRowView(color: color)
                        }
                    }
                }
            }
            .navigationTitle("Colors")
        }
    }
}

#Preview {
    ColorsListView()
        .environmentObject(Model())
}
