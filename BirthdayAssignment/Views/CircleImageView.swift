//
//  CircleImageView.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit

class CircularImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.cornerRadius = min(frame.width, frame.height) / 2
    }
}
