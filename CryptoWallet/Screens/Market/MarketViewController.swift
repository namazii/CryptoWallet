//
//  MarketViewController.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 19.04.2023.
//

import UIKit

final class MarketViewController: UIViewController {
    
    //MARK: - Private Properties
    private var viewModel: MarketViewModel
    private var rootView: MarketView { return self.view as! MarketView }
    
    //MARK: - LifeCycle
    init(marketViewModel: MarketViewModel) {
        self.viewModel = marketViewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = MarketView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        observe()
        fetchCoins()
    }
    
    //MARK: - Private Methods
    private func setup() {
        title = Texts.Market.navTitle
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = rootView.sortBarButton
        navigationItem.leftBarButtonItem = rootView.exitBarButton
    }
    
    private func observe() {
        
        rootView.onCoinSelected = { [weak self] coin in
            guard let self = self else { return }
            self.viewModel.showNextScreen(coin: coin, from: self)
        }
        
        rootView.onSortTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.sortData()
        }
        
        rootView.onExitTapped = {
            self.viewModel.logOut()
            self.viewModel.showOnboardingScreen()
        }
        
        rootView.onPullToRefreshed = {  [weak self] in
            guard let self = self else { return }
            self.fetchCoins()
        }
        
        viewModel.coinsChanged = { [weak self] coins in
            guard let self = self else { return }
            self.rootView.bind(coins)
        }
        
        viewModel.needAlert = { [weak self] bool in
            guard let self = self else { return }
            if bool { self.showAlert(title: Texts.Market.alertTitle, message: Texts.Market.alertMessage) }
        }
    }
    
    private func fetchCoins() {
        viewModel.fetchCoins()
    }
}


