//
//  BirthdayViewModel.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import Foundation

class BirthdayViewModel: ViewModel, ObservableObject {
    
    @Published private(set) var state: State
    private weak var router: BirthdayRouter?
    
    init(state: State, router: BirthdayRouter?) {
        self.state = state
        self.router = router
    }
    
    struct State: Equatable, Hashable {
        var baby: Baby
        
        var title: String {
            "TODAY \(baby.name.uppercased()) IS"
        }
        
        var age: Int {
            let monthsAge = baby.birthdate.monthsPassed
            return monthsAge < 12 ? monthsAge : monthsAge / 12
        }
        
        var subtitle: String {
            let monthsAge = baby.birthdate.monthsPassed
            return if monthsAge < 12 { monthsAge == 1 ? "MONTH OLD" : "MONTHS OLD" }
            else { (monthsAge / 12) == 1 ? "YEAR OLD" : "YEARS OLD" }
        }
    }
    
    enum Action {
        case onBackButtonTap
        case onShareButtonTap
        case setPicute(Data?)
    }
    
    func send(_ action: Action) {
        switch action {
        case .onBackButtonTap:
            router?.didTapBackButton()
        
        case .onShareButtonTap:
            break
            
        case let .setPicute(data):
            state.baby.picture = data
            UserDefaults.standard.baby = state.baby
        }
    }
}
