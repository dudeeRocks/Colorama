// Abstract: Colors list view

import SwiftUI

struct ColorsListView: View {
    
    @EnvironmentObject var model: Model
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("System Colors")) {
                    ForEach(model.systemColors) { color in
                        NavigationLink {
                            ColorDetailsView(color: Binding(get: { color }, set: { _ in }), namespace: namespace)
                                .navigationTitle(color.name)
                        } label: {
                            ColorRowView(color: color, namespace: namespace)
                        }
                    }
                }
                
                Section(header: Text("Custom Colors")) {
                    ForEach(model.customColors) { color in
                        NavigationLink {
                            ColorDetailsView(color: Binding(get: { color }, set: { _ in }), namespace: namespace)
                                .navigationTitle(color.name)
                        } label: {
                            ColorRowView(color: color, namespace: namespace)
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
