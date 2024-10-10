// Abstract: View that displays color details or edit form depending on context

import SwiftUI

struct ColorView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: Model
    @Binding var colorItem: ColorItem
    var isNewColor: Bool = false
    var isSystemColor: Bool = false
    var onDismiss: () -> Void = { }
    
    @State private var isEditing: Bool = false
    @State private var newName: String = ""
    @State private var newColor: Color = .clear
    
    private var title: String {
        if isEditing {
            return "Edit Color"
        } else if isNewColor {
            return "New Color"
        } else {
            return colorItem.name
        }
    }
    
    var body: some View {
        Group {
            if isEditing || isNewColor {
                ColorEditView(
                    newName: $newName,
                    newColor: $newColor,
                    isNewColor: isNewColor,
                    onDelete: {
                        model.removeColor(colorItem)
                        dismiss()
                    }
                )
            } else {
                ColorDetailsView(colorItem: $colorItem)
                    .onAppear {
                        newName = colorItem.name
                        newColor = colorItem.color
                    }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(isEditing)
        .toolbar {
            if isEditing || isNewColor {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if isNewColor {
                            model.addColor(ColorItem(color: newColor, name: newName))
                            onDismiss()
                        } else {
                            colorItem.name = newName
                            colorItem.color = newColor
                            model.updateColor(colorItem)
                            isEditing = false
                        }
                    } label: {
                        Text("Save")
                    }
                    .disabled(newName.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        onDismiss()
                        withAnimation() {
                            isEditing = false
                        }
                    } label: {
                        Text("Cancel")
                    }
                }
            } else {
                if !isSystemColor {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation() {
                                isEditing = true
                            }
                        } label: {
                            Text("Edit")
                        }
                    }
                }
            }
        }
    }
}
