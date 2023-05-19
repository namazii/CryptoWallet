//
//  MarketCell.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 19.04.2023.
//

import UIKit

final class MarketCell: UITableViewCell {
    
    static let reuseID = "MarketCell"
    
    //MARK: - Private Properties
    private let coinImageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let nameCoinLabel = Label(style: .cellHeader, text: "")
    
    private let symbolCoinLabel = Label(style: .cell, text: "")
    
    private let priceLabel = Label(style: .cellHeader, text: "")
    
    private let indexCoinLabel = Label(style: .cell, text: "")
    
    private let chevronImageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let indexPriceStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        stackView.alignment = .trailing
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    //MARK: - LifeCycle
    private override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func bind(_ coin: Coin) {
        
        let text = coin.name
        let symbol = coin.symbol
        let image = coin.slug
        let price = coin.marketData?.priceUsd
        let indexPrice = coin.marketData?.indexLastHour
        
        coinImageView.image = UIImage(named: image)
        nameCoinLabel.text = text
        symbolCoinLabel.text = symbol
        
        guard let indexPrice = indexPrice else { return }
        guard let price = price else { return }
        
        priceLabel.text = "$" + String(format: "%.4f", price)
        indexCoinLabel.text = String(format: "%.4f", indexPrice)
        
        if indexPrice >= 0.0 {
            chevronImageView.image = UIImage(named: Images.arrowUp)
        } else {
            chevronImageView.image = UIImage(named: Images.arrowDown)
        }
    }
}

//MARK: - Private Methods
extension MarketCell {
    
    private func setupView() {
        backgroundColor = Colors.background.uiColor
    }
    
    private func addSubViews() {
        addSubview(coinImageView)
        addSubview(nameStackView)
        addSubview(priceLabel)
        addSubview(indexPriceStackView)
        
        indexPriceStackView.addArrangedSubview(chevronImageView)
        indexPriceStackView.addArrangedSubview(indexCoinLabel)
        
        nameStackView.addArrangedSubview(nameCoinLabel)
        nameStackView.addArrangedSubview(symbolCoinLabel)
    }
}

//MARK: - Setup Constraints
extension MarketCell {
    
    private struct Appearance {
        static let imageCoinHeight: CGFloat = 0.6
        static let xPadding: CGFloat = 25
        static let yPadding: CGFloat = 10
        static let nameStackViewPadding: CGFloat = 19
        static let indexPriceStackViewPadding: CGFloat = 3
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            coinImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Appearance.imageCoinHeight),
            coinImageView.widthAnchor.constraint(equalTo: coinImageView.heightAnchor),
            coinImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.xPadding),
            coinImageView.topAnchor.constraint(equalTo: topAnchor, constant: Appearance.yPadding),
            
            nameStackView.topAnchor.constraint(equalTo: topAnchor,constant: Appearance.yPadding),
            nameStackView.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: Appearance.nameStackViewPadding),
            nameStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Appearance.yPadding),
            
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: Appearance.yPadding),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.xPadding),
            
            indexPriceStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Appearance.indexPriceStackViewPadding),
            indexPriceStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.xPadding),
            indexPriceStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Appearance.yPadding),
            
            chevronImageView.heightAnchor.constraint(equalTo: priceLabel.heightAnchor)
        ])
    }
}
