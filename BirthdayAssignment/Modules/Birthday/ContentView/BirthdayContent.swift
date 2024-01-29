//
//  BirthdayContentView.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 29/01/2024.
//

import UIKit
import SwiftUI

struct BirthdayContentView: UIViewRepresentable {
    
    let theme: BirthdayView.Theme
    let title: String
    let age: Int
    let subtitle: String
    @Binding var imageData: Data?
    var isSnapshot: Bool = false
    
    func makeUIView(context: Context) -> BirthdayContent {
        let uiView = UINib(nibName: String(describing: BirthdayContent.self), bundle: .main)
            .instantiate(withOwner: self).first as! BirthdayContent
        
        uiView.set(
            theme: theme,
            title: title,
            subtitle: subtitle,
            age: age,
            pictureBinding: $imageData,
            isSnapshot: isSnapshot
        )
        
        return uiView
    }
    
    func updateUIView(_ uiView: BirthdayContent, context: Context) {
        uiView.setBabyImage($imageData)
    }
}

class BirthdayContent: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var ageImageView: UIImageView!
    @IBOutlet private weak var babyImageView: UIImageView!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var contentTopConstraint: NSLayoutConstraint!
    
    private var theme: BirthdayView.Theme = .blue
    private var pictureBinding: Binding<Data?> = .empty()
    private var isSnapshot: Bool = false
    private var didSetup: Bool = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard !didSetup else { return }
        didSetup.toggle()
        
        setupCameraButton()
        contentTopConstraint.constant -= hostingController?.navigationController?.navigationBar.frame.height ?? .zero
    }
    
    private func setupCameraButton() {
        guard !isSnapshot else { return }
        
        let cameraButton = addSwiftUIView(
            PicturePicker(
                selection: pictureBinding,
                label: { Image(self.theme.cameraIcon) }
            )
        )
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.centerXAnchor.constraint(equalTo: babyImageView.centerXAnchor).isActive = true
        cameraButton.centerYAnchor.constraint(equalTo: babyImageView.centerYAnchor).isActive = true
        
        alignCameraButton(cameraButton)
        
        (babyImageView as? CircularImageView)?.onSubviewsLayout = { [weak self] in
            self?.alignCameraButton(cameraButton)
        }
    }
    
    private func alignCameraButton(_ button: UIView) {
        let imageViewWidth = babyImageView.bounds.size.width
        
        button.transform = CGAffineTransform(
            translationX: cos(Angle(degrees: -45).radians) * (imageViewWidth / 2),
            y: sin(Angle(degrees: -45).radians) * (imageViewWidth / 2)
        )
    }
    
    func set(theme: BirthdayView.Theme, title: String, subtitle: String, age: Int, pictureBinding: Binding<Data?>, isSnapshot: Bool) {
        self.theme = theme
        self.isSnapshot = isSnapshot
        
        setupTheme()
        setBabyInfo(title, subtitle, age)
        setBabyImage(pictureBinding)
    }
    
    private func setupTheme() {
        backgroundColor = UIColor(resource: theme.backgroundColor)
        backgroundImageView.image = UIImage(resource: theme.backgroundResource)
        
        babyImageView.layer.borderWidth = 7
        babyImageView.image = UIImage(resource: theme.picturePlaceholder)
        babyImageView.layer.borderColor = UIColor(resource: theme.foregroundColor).cgColor
    }
    
    private func setBabyInfo(_ title: String, _ subtitle: String, _ age: Int) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        ageImageView.image = UIImage(named: age.description)
    }
    
    func setBabyImage(_ binding: Binding<Data?>) {
        self.pictureBinding = binding
        
        DispatchQueue.main.async {
            guard let data = binding.wrappedValue, let image = UIImage(data: data) else {
                self.babyImageView.image = UIImage(resource: self.theme.picturePlaceholder)
                return
            }
            
            self.babyImageView.image = image
        }
    }
}
