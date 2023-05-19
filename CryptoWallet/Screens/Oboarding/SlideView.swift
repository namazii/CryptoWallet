//
//  SlideView.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 18.04.2023.
//

import UIKit

final class SlideView: UIView {
    
    //MARK: - Private Properties
    private let pageHeaderLabel = Label(style: .onboarding,
                                        text: "",
                                        color: Colors.onboardDescriptionText.uiColor)
    
    private let pageLabel = Label(style: .onboarding,
                                  text: "",
                                  color: Colors.onboardHeaderText.uiColor)
    
    private let onboardImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubvViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
        pageHeaderLabel.font = UIFont(name: Fonts.poppinsMedium, size: bounds.height * 0.051)
        pageLabel.font = UIFont(name: Fonts.poppinsMedium, size: bounds.height * 0.022)
    }
    
    //MARK: - Public Methods
    public func setPageLabelText(description: String, header: String, image: String ) {
        pageLabel.text = description
        pageHeaderLabel.text = header
        onboardImageView.image = UIImage(named: image)
    }
    
    public func setPageLabelTransform(transform: CGAffineTransform) {
        pageLabel.transform = transform
    }
    
    //MARK: - Private Methods
    private func setupView() {
        backgroundColor = Colors.background.uiColor
    }
    
    private func addSubvViews() {
        addSubview(pageHeaderLabel)
        addSubview(pageLabel)
        addSubview(onboardImageView)
    }
}

//MARK: - Setup Constraints
extension SlideView {
    
    private struct Appearance {
        static let zero: CGFloat = 0
        static let onboardImageViewHeight: CGFloat = 0.38
        static let padding: CGFloat = 30
        static let pageHeaderLabelHeight: CGFloat = 0.19
        static let pageLabelHeight = 0.12
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            onboardImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Appearance.zero),
            onboardImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.zero),
            onboardImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Appearance.zero),
            onboardImageView.bottomAnchor.constraint(equalTo: pageHeaderLabel.topAnchor, constant: Appearance.zero),
            onboardImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Appearance.onboardImageViewHeight),
            
            pageHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.padding),
            pageHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.padding),
            pageHeaderLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Appearance.pageHeaderLabelHeight),
            
            pageLabel.topAnchor.constraint(equalTo: pageHeaderLabel.bottomAnchor, constant: Appearance.zero),
            pageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.padding),
            pageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.padding),
            pageLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Appearance.pageLabelHeight)
        ])
    }
}
