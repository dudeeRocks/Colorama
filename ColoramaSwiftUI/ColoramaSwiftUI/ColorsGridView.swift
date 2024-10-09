//
//  ColorsGridView.swift
//  ColoramaSwiftUI
//
//  Created by David Katsman on 08/10/2024.
//

import SwiftUI

struct ColorsGridView: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        Grid(alignment: .topLeading, horizontalSpacing: 20, verticalSpacing: 20) {
            Section(header: Text("Colors")) {
                GridRow {
                    ForEach(model.systemColors) { color in
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color.color)
                                .frame(width: 30, height: 30)
                            Text(color.name)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ColorsGridView()
}
