// Abstract: simple view displayed when there are no custom colors

import SwiftUI

struct EmptyStateView: View {
    
    @EnvironmentObject var model: Model
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("No custom colors yet.")
                .font(.headline)
                .padding(.top, 20)
            Button {
                isPresented = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add new color")
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
        }
    }
}
