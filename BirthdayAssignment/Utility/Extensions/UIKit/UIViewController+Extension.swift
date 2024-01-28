//
//  UIViewController+Extension.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit
import SwiftUI

extension UIViewController {
    
    func addSwiftUIView(_ view: some View) -> UIView {
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.backgroundColor = .clear
        let addedView = hostingController.view!
        
        addChild(hostingController)
        self.view.addSubview(addedView)
        hostingController.didMove(toParent: self)
        
        return addedView
    }
}
