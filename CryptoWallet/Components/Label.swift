//
//  Label.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 02.05.2023.
//

import UIKit

enum LabelStyle: Int {
    case header
    case coinStatic
    case coinValue
    case onboarding
    case cellHeader
    case cell
}

final class Label: UILabel {
    
    init(style: LabelStyle, text: String, color: UIColor? = nil) {
        super.init(frame: .zero)
        
        switch style {
        case .header: createCoinHeader(text: text, color: color)
        case .coinStatic: createCoinStatic(text: text)
        case .coinValue: createCoinValue(text: text)
        case .onboarding: createOnboarding(color: color)
        case .cellHeader: createCellHeader()
        case .cell: createCell()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCoinHeader(text: String, color: UIColor?) {
        self.text = text
        self.textAlignment = .center
        self.textColor = color
        self.font = UIFont(name: Fonts.poppinsMedium, size: UIScreen.main.bounds.height * 0.04)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createCoinStatic(text: String) {
        self.text = text
        self.textAlignment = .left
        self.textColor = Colors.indexCoin.uiColor
        self.font = UIFont(name: Fonts.poppinsMedium, size: UIScreen.main.bounds.height * 0.02)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createCoinValue(text: String) {
        self.text = text
        self.textAlignment = .right
        self.font = UIFont(name: Fonts.poppinsMedium, size: UIScreen.main.bounds.height * 0.02)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createOnboarding(color: UIColor?) {
        self.textAlignment = .center
        self.numberOfLines = 0
        self.textColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createCellHeader() {
        self.font = UIFont(name: Fonts.poppinsMedium, size: UIScreen.main.bounds.height * 0.023)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createCell() {
        self.font = UIFont(name: Fonts.poppinsMedium, size: UIScreen.main.bounds.height * 0.019)
        self.textColor = Colors.indexCoin.uiColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
