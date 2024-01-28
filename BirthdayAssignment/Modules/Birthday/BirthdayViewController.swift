//
//  BirthdayViewController.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import UIKit
import SwiftUI

class BirthdayViewController: UIViewController {
    
    private var viewModel: BirthdayViewModel!
    private let theme = Theme.allCases.randomElement() ?? .blue
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    
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
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapShareButton() {
        print("Share tapped")
    }
}
