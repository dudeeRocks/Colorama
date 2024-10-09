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
                    if model.customColors.isEmpty {
                        VStack(alignment: .center, spacing: 10) {
                            Text("No custom colors yet.")
                                .font(.headline)
                                .padding()
                            Button {
                                model.customColors.append(.init(color: .red, name: "New color"))
                            } label: {
                                HStack {
                                    Image(systemName: "plus")
                                    Text("Add new color")
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.bottom, 20)
                    } else {
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
            }
            .navigationTitle("Colors")
        }
    }
}

#Preview {
    ColorsListView()
        .environmentObject(Model())
}
