//
//  OnboardingViewController.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 14.05.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    //MARK: - Private Properties
    private var rootView: OnboardingView { return self.view as! OnboardingView }
    private var viewModel: OnboardingViewModel
    
    //MARK: - LifeCycle
    init(onboardingViewModel: OnboardingViewModel) {
        self.viewModel = onboardingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        
        view = OnboardingView(frame: UIScreen.main.bounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observe()
    }
    
    private func observe() {
        rootView.onCloseTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.showNextScreen()
        }
    }
}
