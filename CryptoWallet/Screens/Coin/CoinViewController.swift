//
//  CoinViewController.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 29.04.2023.
//

import UIKit

final class CoinViewController: UIViewController {
    
    //MARK: - Private Properties
    private var viewModel: CoinViewModel
    private var rootView: CoinView { return self.view as! CoinView }
    
    //MARK: - LifeCycle
    init(coinViewModel: CoinViewModel, coin: Coin) {
        self.viewModel = coinViewModel
        viewModel.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = CoinView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observe()
        viewModel.сonvert()
    }
    
    //MARK: - Private Methods
    private func setupView(name: String, symbol: String) {
        title = "\(name)(\(symbol))"
    }
    
    private func observe() {
        viewModel.coinsObserver = { [weak self] coin in
            
            guard let self = self else { return }
            
            self.setupView(name: coin.name, symbol: coin.symbol)
            self.rootView.bind(coin)
        }
    }
}

