//
//  UITextField+SetIcon.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 19.04.2023.
//

import UIKit

extension UITextField {
    func setIcon(_ image: String) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 10, width: 32, height: 32))
        iconView.image = UIImage(named: image)
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 5, width: 50, height: 50))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
