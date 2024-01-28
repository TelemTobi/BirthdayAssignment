//
//  AppCoordinator.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var window: UIWindow
    var childCoordinators: [Coordinator] = []
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController(rootViewController: loginViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func finish() {
        // Won't finish as its the root coordinator
    }
    
    // MARK: - Main Screen
    
    private var loginViewController: UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }
}
