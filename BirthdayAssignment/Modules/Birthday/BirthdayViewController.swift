//
//  BirthdayViewController.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit
import SwiftUI

class BirthdayViewController: UIViewController {
    
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
        view.backgroundColor = UIColor(resource: theme.backgroundColor)
        backgroundImageView.image = UIImage(resource: theme.backgroundResource)
        contentTopConstraint.constant -= navigationController?.navigationBar.frame.height ?? .zero
        
        setupBabyInfo()
        setupBabyImageView()
    }
    
    private func setupBabyInfo() {
        titleLabel.text = viewModel.state.title
        subtitleLabel.text = viewModel.state.subtitle
        ageImageView.image = UIImage(named: viewModel.state.age.description)
    }
    
    private func setupBabyImageView() {
        let imageWidth = babyImageView.frame.width
        let imageHeight = babyImageView.frame.height
        
        babyImageView.layer.masksToBounds = true
        babyImageView.layer.cornerRadius = max(imageWidth, imageHeight) / 2
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
