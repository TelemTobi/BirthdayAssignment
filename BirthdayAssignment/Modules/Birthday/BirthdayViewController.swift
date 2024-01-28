//
//  BirthdayViewController.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit
import SwiftUI
import Combine

class BirthdayViewController: UIViewController {
    
    @IBOutlet private weak var contentView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var ageImageView: UIImageView!
    @IBOutlet private weak var babyImageView: UIImageView!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var contentTopConstraint: NSLayoutConstraint!
    
    private var viewModel: BirthdayViewModel!
    private let theme = Theme.allCases.randomElement() ?? .blue
    private var subscriptions: Set<AnyCancellable> = []
    
    func set(_ viewModel: BirthdayViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerSubscriptions()
        setupUI()
    }
    
    // MARK: - Setup
    
    private func registerSubscriptions() {
        viewModel.$state
            .sink { [weak self] in
                guard let data = $0.baby.picture else { return }
                self?.babyImageView.image = UIImage(data: data)
            }
            .store(in: &subscriptions)
    }
    
    private func setupUI() {
        setupTheme()
        setupConstraints()
        setupBabyInfo()
        setupBabyImageView()
        setupCameraButton()
    }
    
    private func setupTheme() {
        view.backgroundColor = UIColor(resource: theme.backgroundColor)
        backgroundImageView.image = UIImage(resource: theme.backgroundResource)
    }
    
    private func setupConstraints() {
        contentTopConstraint.constant -= navigationController?.navigationBar.frame.height ?? .zero
        
        let contentLeading = contentView.leadingAnchor
            .constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 50)
        contentLeading.priority = .defaultHigh
        contentLeading.isActive = true
        
        let contentTrailing = contentView.trailingAnchor
            .constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 50)
        contentTrailing.priority = .defaultHigh
        contentTrailing.isActive = true
    }
    
    private func setupBabyInfo() {
        titleLabel.text = viewModel.state.title
        subtitleLabel.text = viewModel.state.subtitle
        ageImageView.image = UIImage(named: viewModel.state.age.description)
    }
    
    private func setupBabyImageView() {
        babyImageView.layer.borderWidth = 7
        babyImageView.layer.borderColor = UIColor(resource: theme.foregroundColor).cgColor
        
        if let data = viewModel.state.baby.picture, let image = UIImage(data: data) {
            babyImageView.image = image
        }
    }
    
    private func setupCameraButton() {
        let cameraButton = addSwiftUIView(
            PicturePicker(
                selection: viewModel.binding(
                    get: \.baby.picture,
                    send: BirthdayViewModel.Action.setPicute
                ),
                label: {
                    Image(self.theme.cameraIcon)
                }
            )
        )
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.centerXAnchor.constraint(equalTo: babyImageView.centerXAnchor).isActive = true
        cameraButton.centerYAnchor.constraint(equalTo: babyImageView.centerYAnchor).isActive = true
        
        (babyImageView as? CircularImageView)?.onSubviewsLayout = {
            let imageViewWidth = self.babyImageView.bounds.size.width
            
            cameraButton.transform = CGAffineTransform(
                translationX: cos(Angle(degrees: -45).radians) * (imageViewWidth / 2),
                y: sin(Angle(degrees: -45).radians) * (imageViewWidth / 2)
            )
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapShareButton() {
        print("Share tapped")
    }
}
