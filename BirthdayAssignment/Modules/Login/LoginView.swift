//
//  LoginView.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            Section {
                TextField(
                    "Baby's name",
                    text: viewModel.binding(
                        get: { $0.name ?? .empty },
                        send: LoginViewModel.Action.setName
                    )
                )
                .autocorrectionDisabled()
                
                DatePicker(
                    "Birth date:",
                    selection: viewModel.binding(
                        get: { $0.birthdate ?? .current },
                        send: LoginViewModel.Action.setBirthdate
                    ),
                    in: ...Date(),
                    displayedComponents: .date
                )
                
            } footer: {
                Button(
                    action: { viewModel.send(.onProceedButtonTap) },
                    label: {
                        Text("Show birthday screen")
                            .frame(maxWidth: .infinity)
                    }
                )
                .padding(.top)
                .buttonStyle(.bordered)
                .disabled(!viewModel.state.isProceedButtonEnabled)
            }
        }
        .navigationTitle("Details")
    }
}

#Preview {
    NavigationStack {
        LoginView(viewModel: .init(state: .init(), router: nil))
    }
}
