//
//  BirthdayFactory.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit

class BirthdayFactory {
    
    static func makeViewController(using viewModel: BirthdayViewModel) -> UIViewController {
        let identifier = String(describing: BirthdayViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: .main)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? BirthdayViewController else {
            fatalError("View controller with identifier: \(identifier) not found")
        }
        
        viewController.set(viewModel)
        return viewController
    }
}
