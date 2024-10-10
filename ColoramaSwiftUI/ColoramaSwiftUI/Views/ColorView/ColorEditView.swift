// ABstract: view for editing colors

import SwiftUI

struct ColorEditView: View {
    @Binding var newName: String
    @Binding var newColor: Color
    let isNewColor: Bool
    let onDelete: () -> Void
    
    var body: some View {
        Form {
            Section(header: Text("Color")) {
                ColorPicker("Color Value", selection: $newColor, supportsOpacity: false)
            }
            Section(header: Text("Name")) {
                TextField("Name", text: $newName)
            }
            if !isNewColor {
                Section {
                    Button("Delete Color", role: .destructive) {
                        onDelete()
                    }
                }
            }
        }
    }
}
