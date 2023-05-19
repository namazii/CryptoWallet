//
//  UIView+PinEdges.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 26.04.2023.
//

import UIKit.UILayoutGuide

extension UIView {
    
    func pinEdgesToSuperView(_ constant: CGFloat = 0) {
        
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: constant)
        ])
    }
}

