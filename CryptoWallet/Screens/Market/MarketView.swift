//
//  MarketView.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 08.05.2023.
//

import UIKit

final class MarketView: UIView {
    
    //MARK: - Public Properties
    var onSortTapped: (()->()) = {}
    var onExitTapped: (()->()) = {}
    var onPullToRefreshed: (()->()) = {}
    var onCoinSelected: ((Coin)->())?
    
    lazy var sortBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Texts.Market.sort,
                                     style: .done,
                                     target: self,
                                     action: #selector(sortButtonTapped))
        
        return button
    }()
    
    lazy var exitBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Texts.Market.exit,
                                     style: .done,
                                     target: self,
                                     action: #selector(exitButtonTapped))
        
        return button
    }()
    
    //MARK: - Private Properties
    private var coins: [CoinResponse] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var stopSkeleton = false
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(MarketCell.self, forCellReuseIdentifier: MarketCell.reuseID)
        tableView.register(MarketSkeletonCell.self, forCellReuseIdentifier: MarketSkeletonCell.reuseID)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.background.uiColor
        tableView.rowHeight = bounds.height / 13.3
        
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func bind(_ coins: [CoinResponse]) {
        self.coins = coins
        stopSkeleton = true
    }
    
    //MARK: - Actions
    @objc private func sortButtonTapped() {
        onSortTapped()
    }
    
    @objc private func exitButtonTapped() {
        onExitTapped()
    }
    
    @objc private func pullToRefresh() {
        refreshControl.beginRefreshing()
        onPullToRefreshed()
        refreshControl.endRefreshing()
    }
}

//MARK: - Private Methods
extension MarketView {
    
    private func setupViews() {
        backgroundColor = Colors.background.uiColor
        self.addSubview(tableView)
    }
    private func setupConstraints() {
        tableView.pinEdgesToSuperView()
    }
}

//MARK: - UITableViewDelegate
extension MarketView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if coins.isEmpty { return }
        guard let coin = coins[indexPath.row].data else { return }
        
        onCoinSelected?(coin)
    }
}

//MARK: - UITableViewDataSource
extension MarketView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if coins.isEmpty { return 9 }
        
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if coins.isEmpty {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketSkeletonCell.reuseID, for: indexPath) as? MarketSkeletonCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            if stopSkeleton { cell.isHidden = true }
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketCell.reuseID, for: indexPath) as? MarketCell else { return UITableViewCell() }
        
        if !coins.isEmpty, let coin = coins[indexPath.row].data {
            
            cell.bind(coin)
            
        }
        return cell
    }
}

