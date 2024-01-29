//
//  BirthdayView.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 29/01/2024.
//

import SwiftUI

struct BirthdayView: View {
    
    @ObservedObject private var viewModel: BirthdayViewModel
    
    init(viewModel: BirthdayViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        BirthdayContentView(
            title: viewModel.state.title,
            age: viewModel.state.age,
            subtitle: viewModel.state.subtitle,
            imageData: viewModel.binding(
                get: \.baby.picture,
                send: BirthdayViewModel.Action.setPicute
            )
        )
        .ignoresSafeArea()
    }
}

#Preview {
    let mock = Baby(name: "Cristiano Ronaldo", birthdate: .current)
    return BirthdayView(viewModel: .init(state: .init(baby: mock), router: nil))
}
