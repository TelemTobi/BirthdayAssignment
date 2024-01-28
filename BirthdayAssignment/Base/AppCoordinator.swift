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
        let baby = UserDefaults.standard.baby
        
        let loginViewModel = LoginViewModel(
            state: .init(name: baby?.name, birthdate: baby?.birthdate, picture: baby?.picture),
            router: self
        )
        
        let loginView = LoginView(viewModel: loginViewModel)
        return UIHostingController(rootView: loginView)
    }
    
    func didLoginSuccessfuly(baby: Baby) {
        // TODO: Progress to birthdayView
    }
}
