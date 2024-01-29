//
//  Binding+Extension.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 29/01/2024.
//

import SwiftUI

extension Binding {
    
    static func empty<T>() -> Binding<Value> where T? == Value {
        Binding<Value>(get: { nil }, set: { _ in })
    }
}
