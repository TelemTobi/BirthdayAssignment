//
//  Coordinator.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var window: UIWindow { get }
    var childCoordinators: [Coordinator] { get set }
    
    init(window: UIWindow)
    
    /**
     Starts a new flow.
     
     Use this function to initiate the first screen of the flow.
     */
    func start()
    
    /**
     Finishes the flow.
     
     Use this function to execute common business logic when finishing (exiting) the flow.
     - Note:
     Remember to call `parentCoordinator?.childDidFinish(self)` to de-allocate the coordinator.
     */
    func finish()
    
    /**
     Implement for close button ( ✕ ) functionality.
     
     - NOTE: Remember in case of finishing the whole flow to call `finish()` function, so the child coordinator will be de-allocated the coordinator. Otherwise - memory leaks are likely to happen.
     */
    func didTapCloseButton()
    
    /**
     Implement for back button ( → ) functionality.
     */
    func didTapBackButton()
}

extension Coordinator {
    
    var rootNavigationController: UINavigationController? {
        
        if let navigationController = rootViewController() as? UINavigationController {
            return navigationController
        }
        return rootViewController()?.navigationController
    }
    
    func rootViewController(_ base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? window.rootViewController
        
        if let nav = base as? UINavigationController {
            return rootViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                
                if (selected as? UINavigationController)?.viewControllers.isEmpty ?? false {
                    return rootViewController(tab.moreNavigationController)
                }
                
                return rootViewController(selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return rootViewController(presented)
        }
        return base
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        rootViewController()?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animated: Bool = true) {
        rootViewController()?.navigationController?.popViewController(animated: animated)
    }
    
    func present(_ viewController: UIViewController, presentationStyle: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, animated: Bool = true, completion: EmptyClosure? = nil) {
        viewController.modalPresentationStyle = presentationStyle
        viewController.modalTransitionStyle = transitionStyle
        rootViewController()?.present(viewController, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool = true, completion: EmptyClosure? = nil) {
        rootViewController()?.dismiss(animated: animated, completion: completion)
    }
    
    /**
     De-allocates a child coordinator from its parent.
     
     - parameters:
        - child: the instance of the child coordinator (usually using `self`) to de-allocate.
     */
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                #if DEBUG
                printChildRemoval(coordinator)
                #endif
                break
            }
        }
    }
    
    func didTapCloseButton() {
        // Keep empty as this is the main app coordinator and it should not close
    }
    
    func didTapBackButton() {
        if rootViewController()?.navigationController?.viewControllers.count == 1 {
            dismiss()
        } else {
            rootViewController()?.navigationController?.popViewController(animated: true)
        }
    }
    
    #if DEBUG
    func printChildRemoval(_ child: Coordinator) {
        print("👋🏼 \(String(describing: type(of: child))) was removed from its parent (\(String(describing: type(of: self))))")
    }
    #endif
}

