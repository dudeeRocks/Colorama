//
//  ColorsGridView.swift
//  ColoramaSwiftUI
//
//  Created by David Katsman on 08/10/2024.
//

import SwiftUI

struct ColorsGridView: View {
    
    @EnvironmentObject var model: Model
    
    private let columns: [GridItem] = .init(repeating: GridItem(.adaptive(minimum: 80, maximum: 120), spacing: 20), count: 3)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("System Colors".uppercased())
                    .gridSectionHeader()
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(model.systemColors) { color in
                        NavigationLink {
                            ColorDetailsView(color: Binding(get: { color }, set: { _ in }))
                                .setNavigationTitle(to: color.name)
                        } label: {
                            ColorCellView(color: color)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Text("Custom Colors".uppercased())
                    .gridSectionHeader()
                
                if model.customColors.isEmpty {
                    EmptyStateView()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.background)
                        }
                        .padding(.horizontal, 20)
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach($model.customColors) { color in
                            NavigationLink {
                                ColorDetailsView(color: color)
                                    .setNavigationTitle(to: color.name.wrappedValue)
                            } label: {
                                ColorCellView(color: color.wrappedValue)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationTitle("Colors")
            .background(.gray.opacity(0.15))
        }
    }
}

extension Text {
    func gridSectionHeader() -> some View {
        self
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding(.top, 20)
    }
}

#Preview {
    ColorsGridView()
        .environmentObject(Model())
}
