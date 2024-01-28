//
//  Baby.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import Foundation

struct Baby: Codable, Equatable, Hashable {
    
    let name: String
    let birthdate: Date
    var picture: Data?
}
