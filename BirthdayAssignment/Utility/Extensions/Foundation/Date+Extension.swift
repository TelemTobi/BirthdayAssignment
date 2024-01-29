//
//  Date+Extension.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import Foundation

extension Date {
    
    static var current: Date { Date() }
    
    var monthsPassed: Int {
        Calendar(identifier: .gregorian).dateComponents([.month], from: self, to: Date()).month ?? .zero
    }
}
