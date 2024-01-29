//
//  UIView+Extension.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit
import SwiftUI

extension UIView {
    
    var hostingController: UIViewController? {
        return if let nextResponder = self.next as? UIViewController {
            nextResponder
        } else if let nextResponder = self.next as? UIView {
            nextResponder.hostingController
        } else {
            nil
        }
    }
    
    func addSwiftUIView(_ view: some View) -> UIView {
        let viewController = UIHostingController(rootView: view)
        viewController.view.backgroundColor = .clear
        let addedView = viewController.view!
        
        hostingController?.addChild(viewController)
        self.addSubview(addedView)
        viewController.didMove(toParent: hostingController)
        
        return addedView
    }
}
