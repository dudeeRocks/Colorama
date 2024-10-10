// Abstract: view modifier to apply navigation title to both collection types : list and grid

import SwiftUI

struct NavigationTitle: ViewModifier {
    @Binding var isSheetPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .navigationTitle("Colors")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                NavigationStack {
                    ColorView(
                        colorItem: .init(get: { .newColor }, set: { _ in }),
                        isNewColor: true,
                        onDismiss: { isSheetPresented = false }
                    )
                }
            }
    }
}

extension View {
    func colorsNavigationTitle(isSheetPresented: Binding<Bool>) -> some View {
        self.modifier(NavigationTitle(isSheetPresented: isSheetPresented))
    }
}
