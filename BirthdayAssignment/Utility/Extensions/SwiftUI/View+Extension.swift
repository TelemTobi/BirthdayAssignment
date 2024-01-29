//
//  View+Extension.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 29/01/2024.
//

import SwiftUI

extension View {
    
    @MainActor
    func renderSnapshot(using size: CGSize) -> UIImage {
        let hostingController = UIHostingController(rootView: self)
        hostingController.view.frame = .init(origin: .zero, size: size)
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { _ in
            hostingController.view.drawHierarchy(in: hostingController.view.bounds, afterScreenUpdates: true)
        }
    }
}
