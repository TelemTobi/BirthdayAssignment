//
//  AppCoordinator.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit
import SwiftUI

class AppCoordinator: Coordinator, LoginRouter {
    
    var window: UIWindow
    var childCoordinators: [Coordinator] = []
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func finish() {
        // Won't finish as its the root coordinator
    }
    
    // MARK: - Login
    
    private var loginViewController: UIViewController {
        let loginViewModel = LoginViewModel(
            state: .init(), // TODO: Inject persisted data
            router: self
        )
        
        let loginView = LoginView(viewModel: loginViewModel)
        return UIHostingController(rootView: loginView)
    }
    
    func didLoginSuccessfuly() {
        // TODO: Progress to birthdayView
    }
}
