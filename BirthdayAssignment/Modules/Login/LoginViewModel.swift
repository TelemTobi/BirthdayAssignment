//
//  LoginViewModel.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import Foundation

class LoginViewModel: ViewModel, ObservableObject {
    
    @Published private(set) var state: State
    private weak var router: LoginRouter?
    
    init(state: State, router: LoginRouter?) {
        self.state = state
        self.router = router
    }
    
    struct State: Equatable, Hashable {
        var name: String?
        var birthdate: Date?
        var picture: Data?
        
        var hasPicture: Bool {
            picture != nil
        }
        
        var isProceedButtonEnabled: Bool {
            name?.isEmpty == false && birthdate != nil
        }
    }
    
    enum Action {
        case setName(String)
        case setBirthdate(Date)
        case setPicute(Data?)
        
        case onProceedButtonTap
    }
    
    func send(_ action: Action) {
        switch action {
        case let .setName(name):
            state.name = name
            
        case let .setBirthdate(date):
            state.birthdate = date
            
        case let .setPicute(data):
            state.picture = data
            
        case .onProceedButtonTap:
            break // TODO: Proceed to Birthday screen
        }
    }
}
