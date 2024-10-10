// ABstract: view for editing colors

import SwiftUI

struct ColorEditView: View {
    
    @Binding var colorItem: ColorItem
    @Binding var newName: String
    @Binding var newColor: Color
    
    var body: some View {
        Form {
            Section(header: Text("Color")) {
                ColorPicker("Color Value", selection: $newColor, supportsOpacity: false)
            }
            Section(header: Text("Name")) {
                TextField("Name", text: $newName)
            }
        }
    }
}
