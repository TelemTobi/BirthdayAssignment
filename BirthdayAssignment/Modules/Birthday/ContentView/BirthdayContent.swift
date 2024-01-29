//
//  BirthdayContentView.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 29/01/2024.
//

import UIKit
import SwiftUI

struct BirthdayContentView: UIViewRepresentable {
    
    let title: String
    let age: Int
    let subtitle: String
    
    @Binding var imageData: Data?
    
    func makeUIView(context: Context) -> BirthdayContent {
        let uiView = UINib(nibName: String(describing: BirthdayContent.self), bundle: .main)
            .instantiate(withOwner: self).first as! BirthdayContent
        
        uiView.setBabyInfo(title, subtitle, age)
        uiView.setBabyImage($imageData)
        return uiView
    }
    
    func updateUIView(_ uiView: BirthdayContent, context: Context) {
        uiView.setBabyImage($imageData)
    }
}

class BirthdayContent: UIView {
    
    @IBOutlet private weak var contentView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var ageImageView: UIImageView!
    @IBOutlet private weak var babyImageView: UIImageView!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var contentTopConstraint: NSLayoutConstraint!
    
    private let theme = Theme.allCases.randomElement() ?? .blue
    private var pictureBinding: Binding<Data?>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupCameraButton()
        contentTopConstraint.constant -= hostingController?.navigationController?.navigationBar.frame.height ?? .zero
    }
    
    private func setup() {
        setupContraints()
        setupTheme()
    }
    
    private func setupContraints() {
        let contentLeading = contentView.leadingAnchor
            .constraint(greaterThanOrEqualTo: leadingAnchor, constant: 50)
        contentLeading.priority = .defaultHigh
        contentLeading.isActive = true
        
        let contentTrailing = contentView.trailingAnchor
            .constraint(greaterThanOrEqualTo: trailingAnchor, constant: 50)
        contentTrailing.priority = .defaultHigh
        contentTrailing.isActive = true
    }
    
    private func setupTheme() {
        backgroundColor = UIColor(resource: theme.backgroundColor)
        backgroundImageView.image = UIImage(resource: theme.backgroundResource)
        
        babyImageView.layer.borderWidth = 7
        babyImageView.image = UIImage(resource: theme.picturePlaceholder)
        babyImageView.layer.borderColor = UIColor(resource: theme.foregroundColor).cgColor
    }
    
    private func setupCameraButton() {
        guard let pictureBinding else { return }
        
        let cameraButton = addSwiftUIView(
            PicturePicker(
                selection: pictureBinding,
                label: { Image(self.theme.cameraIcon) }
            )
        )
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.centerXAnchor.constraint(equalTo: babyImageView.centerXAnchor).isActive = true
        cameraButton.centerYAnchor.constraint(equalTo: babyImageView.centerYAnchor).isActive = true
        
        (babyImageView as? CircularImageView)?.onSubviewsLayout = { [weak self] in
            guard let self else { return }
            
            let imageViewWidth = babyImageView.bounds.size.width
            
            cameraButton.transform = CGAffineTransform(
                translationX: cos(Angle(degrees: -45).radians) * (imageViewWidth / 2),
                y: sin(Angle(degrees: -45).radians) * (imageViewWidth / 2)
            )
        }
    }
    
    func setBabyInfo(_ title: String, _ subtitle: String, _ age: Int) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        ageImageView.image = UIImage(named: age.description)
    }
    
    func setBabyImage(_ binding: Binding<Data?>) {
        self.pictureBinding = binding
        
        guard let data = binding.wrappedValue, let image = UIImage(data: data) else {
            babyImageView.image = UIImage(resource: theme.picturePlaceholder)
            return
        }
        
        babyImageView.image = image
    }
}
