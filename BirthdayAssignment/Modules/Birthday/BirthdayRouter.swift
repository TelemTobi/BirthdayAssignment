//
//  BirthdayRouter.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit

protocol BirthdayRouter where Self : Coordinator {
    func share(_ snapshot: UIImage, message: String)
}
