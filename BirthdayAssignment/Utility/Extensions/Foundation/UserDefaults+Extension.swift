//
//  UserDefaults+Extension.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import Foundation

extension UserDefaults {
    
    var baby: Baby? {
        get {
            guard let data = value(forKey: #function) as? Data else { return nil }
            return try? JSONDecoder().decode(Baby.self, from: data)
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            setValue(data, forKey: #function)
        }
    }
}
