//
//  BirthdayViewController.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit
import SwiftUI

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
    
    func set(_ viewModel: BirthdayViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTheme()
        setupConstraints()
        setupBabyInfo()
        setupBabyImageView()
    }
    
    private func setupTheme() {
        view.backgroundColor = UIColor(resource: theme.backgroundColor)
        backgroundImageView.image = UIImage(resource: theme.backgroundResource)
    }
    
    private func setupConstraints() {
        contentTopConstraint.constant -= navigationController?.navigationBar.frame.height ?? .zero
        
        let contentLeading = contentView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 50)
        contentLeading.priority = .defaultHigh
        contentLeading.isActive = true
        
        let contentTrailing = contentView.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 50)
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
    
    // MARK: - Actions
    
    @IBAction private func didTapShareButton() {
        print("Share tapped")
    }
}
