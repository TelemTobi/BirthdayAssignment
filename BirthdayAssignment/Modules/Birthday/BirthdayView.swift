//
//  BirthdayView.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 29/01/2024.
//

import SwiftUI

struct BirthdayView: View {
    
    @ObservedObject private var viewModel: BirthdayViewModel
    @Environment(\.dismiss) private var dismiss

    private let theme = Theme.allCases.randomElement() ?? .blue
    
    init(viewModel: BirthdayViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            birthdayContentView()
                .toolbar { toolbarContent(geometry) }
                .navigationBarBackButtonHidden()
        }
    }
    
    @ViewBuilder
    private func birthdayContentView(isSnapshot: Bool = false) -> some View {
        BirthdayContentView(
            theme: theme,
            title: viewModel.state.title,
            age: viewModel.state.age,
            subtitle: viewModel.state.subtitle,
            imageData: viewModel.binding(
                get: \.baby.picture,
                send: BirthdayViewModel.Action.setPicture
            ),
            isSnapshot: isSnapshot
        )
        .ignoresSafeArea()
    }
    
    @ToolbarContentBuilder
    private func toolbarContent(_ geometry: GeometryProxy) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(
                action: {
                    let snapshot = birthdayContentView(isSnapshot: true)
                        .renderSnapshot(using: geometry.size)
                    
                    let message = "It's \(viewModel.state.baby.name)'s birthday!"
                    
                    viewModel.send(
                        BirthdayViewModel.Action.onShareButtonTap(snapshot, message)
                    )
                },
                label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.primary)
                }
            )
        }
        
        ToolbarItem(placement: .navigationBarLeading) {
            Button(
                action: { dismiss() },
                label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.primary)
                }
            )
        }
    }
}

#Preview {
    let mock = Baby(name: "Cristiano Ronaldo", birthdate: .current)
    return BirthdayView(viewModel: .init(state: .init(baby: mock), router: nil))
}
