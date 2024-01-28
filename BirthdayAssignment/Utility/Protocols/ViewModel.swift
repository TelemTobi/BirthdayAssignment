//
//  ViewModel.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import Combine
import SwiftUI

protocol ViewModel where Self : ObservableObject {
    
    associatedtype State : Equatable, Hashable
    associatedtype Action
    
    var state: State { get }
    
    func send(_ action: Action)
}

extension ViewModel {
    
    /// Derives a binding from the viewModel that prevents direct writes to state
    /// and instead sends action to the viewModel.
    func binding<Value>(
        get state: @escaping (State) -> Value,
        send valueToAction: @escaping (_ value: Value) -> Action
    ) -> Binding<Value> {
        
        ObservedObject(wrappedValue: self)
            .projectedValue[get: .init(rawValue: state), send: .init(rawValue: valueToAction)]
    }
    
    private subscript<Value>(
        get fromState: HashableWrapper<(State) -> Value>,
        send toAction: HashableWrapper<(Value) -> Action?>
    ) -> Value {
        get { fromState.rawValue(self.state) }
        set {
            BindingLocal.$isActive.withValue(true) {
                if let action = toAction.rawValue(newValue) {
                    self.send(action)
                }
            }
        }
    }
}

private struct HashableWrapper<Value>: Hashable {
    let rawValue: Value
    static func == (lhs: Self, rhs: Self) -> Bool { false }
    func hash(into hasher: inout Hasher) {}
}

private enum BindingLocal {
  @TaskLocal static var isActive = false
}
