//
//  MarketSkeletonCell.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 26.04.2023.
//
//

import UIKit

final class MarketSkeletonCell: UITableViewCell {
    
    static let reuseID = "MarketSkeletonCell"
    
    //MARK: - Private Properties
    private let coinLayer = CAGradientLayer()
    private let coinView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupSkeleton()
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayers()
    }
    
    //MARK: - Private Methods
    private func setupLayers() {
        coinLayer.frame = coinView.bounds
        coinLayer.cornerRadius = coinView.bounds.height / 2
    }
    
    private func setupView() {
        backgroundColor = Colors.background.uiColor
    }
    
    private func addSubViews() {
        addSubview(coinView)
    }
}

//MARK: - Setup Constraints
extension MarketSkeletonCell {
    
    private struct Appearance {
        static let width: CGFloat = UIScreen.main.bounds.width
        static let padding: CGFloat = 5
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            coinView.widthAnchor.constraint(equalToConstant: Appearance.width),
            coinView.topAnchor.constraint(equalTo: topAnchor, constant: Appearance.padding),
            coinView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Appearance.padding),
        ])
    }
}

//MARK: - SkeletonLoadable
extension MarketSkeletonCell: SkeletonLoadable {
    
    private func setupSkeleton() {
        coinLayer.startPoint = CGPoint(x: 0, y: 0.5)
        coinLayer.endPoint = CGPoint(x: 1, y: 0.5)
        coinView.layer.addSublayer(coinLayer)
        
        let headGroup = makeAnimationGroup()
        headGroup.beginTime = 0.0
        coinLayer.add(headGroup, forKey: "backgroundColor")
    }
}
