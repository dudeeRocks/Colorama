// Abstract: The entry point to the app.
//           I implemented tabs with both the `Tab` view and the `.tabItem` modifier for future reference.

import SwiftUI

struct RootView: View {
    
    @StateObject var model: Model = .init()
    
    var body: some View {
            if #available (iOS 18.0, *) {
                TabView {
                    Tab("List", systemImage: "list.bullet") {
                        ColorsListView()
                    }
                    
                    Tab("Grid", systemImage: "square.grid.2x2.fill") {
                        ColorsGridView()
                    }
                }
                .environmentObject(model)
            } else {
                TabView {
                    ColorsListView()
                        .tabItem {
                            Label("List", systemImage: "list.bullet")
                        }
                    
                    ColorsGridView()
                        .tabItem {
                            Label("Grid", systemImage: "square.grid.2x2.fill")
                        }
                }
                .environmentObject(model)
            }
    }
}

#Preview {
    RootView()
}
