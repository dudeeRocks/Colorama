// Abstract: The entry point to the app.

import SwiftUI

struct RootView: View {
    
    @StateObject var model: Model = .init()
    
    var body: some View {
        TabView {
            Tab("List", systemImage: "list.bullet") {
                ColorsListView()
            }
            
            Tab("Grid", systemImage: "square.grid.2x2.fill") {
                ColorsGridView()
            }
        }
        .environmentObject(model)
    }
}

#Preview {
    RootView()
}
