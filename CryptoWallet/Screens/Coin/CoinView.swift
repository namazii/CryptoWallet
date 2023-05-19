//
//  CoinView.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 13.05.2023.
//

import UIKit

final class CoinView: UIView {
    
    //MARK: - Private Properties
    private let priceLabel = Label(style: .header, text: "")
    
    private let headerLabel = Label(style: .header,
                                    text: Texts.Coin.header)
    
    private let lastUpdateLabel = Label(style: .coinStatic,
                                        text: Texts.Coin.lastUpdate)
    
    private let lastUpdateValueLabel = Label(style: .coinValue, text: "")
    
    private let volumeLastDayLabel = Label(style: .coinStatic,
                                           text: Texts.Coin.volume)
    
    private let volumeLastDayValueLabel = Label(style: .coinValue, text: "")
    
    private let indexDayLabel = Label(style: .coinStatic,
                                      text: Texts.Coin.index)
    
    private let indexDayValueLabel = Label(style: .coinValue, text: "")
    
    private let indexPriceLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.textColor = Colors.indexCoin.uiColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let coinImageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let backView: UIView = {
        let view = UIView()
        
        view.backgroundColor = Colors.white.uiColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //MARK: - Stacks
    private let priceBtcStack: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 3
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let volumeLastDayStack: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 3
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let indexDayStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 3
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
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
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstrainst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        roundTopCorners(view: backView)
    }
    
    //MARK: - Public Methods
    func bind(_ coin: CoinData) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: DispatchWorkItem { [weak self] in
            
            guard let self = self else { return }
            self.priceLabel.text = coin.price
            self.indexPriceLabel.text = coin.indexLastHour
            self.coinImageView.image = UIImage(named: coin.image)
            self.lastUpdateValueLabel.text = coin.lastTrade
            self.volumeLastDayValueLabel.text = coin.marketVolume
            self.indexDayValueLabel.text = coin.indexLastDay
            
            if coin.icon {
                self.chevronImageView.image = UIImage(named: Images.arrowUp)
            } else {
                self.chevronImageView.image = UIImage(named: Images.arrowDown)
            }
        })
    }
}

//MARK: - Private Methods
extension CoinView {
    
    private func roundTopCorners(view: UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: view.bounds.width * 0.1, height: view.bounds.height * 0.1))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        
        view.layer.mask = maskLayer
        
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func addSubviews() {
        addSubview(priceLabel)
        addSubview(indexPriceStackView)
        addSubview(coinImageView)
        addSubview(backView)
        
        backView.addSubview(headerStackView)
        
        indexPriceStackView.addArrangedSubview(chevronImageView)
        indexPriceStackView.addArrangedSubview(indexPriceLabel)
        
        headerStackView.addArrangedSubview(headerLabel)
        headerStackView.addArrangedSubview(priceBtcStack)
        headerStackView.addArrangedSubview(volumeLastDayStack)
        headerStackView.addArrangedSubview(indexDayStackView)
        
        priceBtcStack.addArrangedSubview(lastUpdateLabel)
        priceBtcStack.addArrangedSubview(lastUpdateValueLabel)
        
        volumeLastDayStack.addArrangedSubview(volumeLastDayLabel)
        volumeLastDayStack.addArrangedSubview(volumeLastDayValueLabel)
        
        indexDayStackView.addArrangedSubview(indexDayLabel)
        indexDayStackView.addArrangedSubview(indexDayValueLabel)
    }
    
    private func setupView() {
        backgroundColor = Colors.background.uiColor
    }
    
    private struct Appearance {
        static let topPadding: CGFloat = 20
        static let Padding: CGFloat = 16
        static let chevronImageHeight: CGFloat = 0.9
        static let commonHeight: CGFloat = 0.3
    }
    
    private func setupConstrainst() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Appearance.topPadding),
            priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            indexPriceStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            indexPriceStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            chevronImageView.heightAnchor.constraint(equalTo: indexPriceLabel.heightAnchor, multiplier: Appearance.chevronImageHeight),
            
            coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            coinImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Appearance.commonHeight),
            coinImageView.widthAnchor.constraint(equalTo: coinImageView.heightAnchor),
            
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Appearance.commonHeight),
            
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.Padding),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.Padding),
            headerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Appearance.topPadding)
        ])
    }
}
