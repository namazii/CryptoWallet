//
//  Button.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 02.05.2023.
//

import UIKit

enum ButtonStyle: Int {
    case main
}

final class Button: UIButton {
    
    var onAction: (()->())?
    
    init(style: ButtonStyle, text: String) {
        super.init(frame: .zero)
        
        switch style {
        case .main : createMainButton(text: text)
        }
        
        self.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        self.onAction?()
    }
    
    private func createMainButton(text: String) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(Colors.white.uiColor, for: .normal)
        self.backgroundColor = Colors.registerButton.uiColor
        self.titleLabel?.font = UIFont(name: Fonts.poppinsSemiBold, size: 15)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
    }
}
