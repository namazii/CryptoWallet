//
//  OnboardingVC.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 18.04.2023.
//

import UIKit

final class OnboardingView: UIView {
    
    //MARK: - Public Properties
    var onCloseTapped: (()->()) = {}
    
    //MARK: - Private Properties
    private var slides = [SlideView]()
    
    private lazy var closeButton = Button(style: .main,
                                          text: Texts.Onboarding.close)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        let pageCotrol = UIPageControl()
        
        pageCotrol.numberOfPages = 3
        pageCotrol.pageIndicatorTintColor = Colors.onboardDisablePoint.uiColor
        pageCotrol.currentPageIndicatorTintColor = Colors.onboadrCurrentPoint.uiColor
        pageCotrol.translatesAutoresizingMaskIntoConstraints = false
        
        return pageCotrol
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstraints()
        scrollView.delegate = self
        slides = createSlides()
        
        closeButton.isHidden = true
        closeButton.onAction = { [weak self] in
            guard let self = self else { return }
            self.onCloseTapped()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupSlidesScrollView(slides: slides)
        
        closeButton.layer.cornerRadius = closeButton.bounds.height / 2
    }
    
    //MARK: - Private Methods
    private func setupView() {
        backgroundColor = Colors.background.uiColor
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        addSubview(pageControl)
        addSubview(closeButton)
    }
    
    private func createSlides() -> [SlideView] {
        let firstOnboardingView = SlideView()
        firstOnboardingView.setPageLabelText(description: Texts.Onboarding.firstDescription,
                                             header: Texts.Onboarding.firstHeader,
                                             image: Images.onboardingOne)
        
        let secondOboardingView = SlideView()
        secondOboardingView.setPageLabelText(description: Texts.Onboarding.secondDescription,
                                             header: Texts.Onboarding.secondHeader,
                                             image: Images.onboardingTwo)
        
        let thirdOboardingView = SlideView()
        thirdOboardingView .setPageLabelText(description: Texts.Onboarding.thirdDescription,
                                             header: Texts.Onboarding.thirdHeader,
                                             image: Images.onboardingThree)
        
        return [firstOnboardingView, secondOboardingView, thirdOboardingView]
    }
    
    private func setupSlidesScrollView(slides: [SlideView]) {
        scrollView.contentSize = CGSize(width: frame.width * CGFloat(slides.count),
                                        height: frame.width)
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: frame.width * CGFloat(i),
                                     y: 0,
                                     width: frame.width,
                                     height: frame.height)
            scrollView.addSubview(slides[i])
        }
    }
}

//MARK: - UIScrollViewDelegate
extension OnboardingView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maxHorizontalOffset = scrollView.contentSize.width - frame.width
        let percentHorizontalOffset = scrollView.contentOffset.x / maxHorizontalOffset
        
        if percentHorizontalOffset <= 0.5 {
            let firstTransform = CGAffineTransform(scaleX: (0.5 - percentHorizontalOffset) / 0.5,
                                                   y: (0.5 - percentHorizontalOffset) / 0.5)
            let secondTransform = CGAffineTransform(scaleX: percentHorizontalOffset / 0.5,
                                                    y: percentHorizontalOffset / 0.5)
            slides[0].setPageLabelTransform(transform: firstTransform)
            slides[1].setPageLabelTransform(transform: secondTransform)
            
        } else {
            let secondTransform = CGAffineTransform(scaleX: (1 - percentHorizontalOffset) / 0.5,
                                                    y: (1 - percentHorizontalOffset) / 0.5)
            let thirdTransform = CGAffineTransform(scaleX: percentHorizontalOffset,
                                                   y: percentHorizontalOffset)
            slides[1].setPageLabelTransform(transform: secondTransform)
            slides[2].setPageLabelTransform(transform: thirdTransform)
        }
        
        if percentHorizontalOffset == 1.0 { closeButton.isHidden = false }
    }
}

//MARK: - Setup Constraints
extension OnboardingView {
    
    private struct Appearance {
        static let zero: CGFloat = 0
        static let nextButtonXPadding: CGFloat = 25
        static let nextButtonYPadding: CGFloat = -10
        static let pageControl: CGFloat = 30
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: Appearance.zero),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.zero),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Appearance.zero),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Appearance.zero),
            
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.nextButtonXPadding),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.nextButtonXPadding),
            closeButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: Appearance.nextButtonYPadding),
            
            pageControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Appearance.pageControl),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.pageControl),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.pageControl),
            pageControl.heightAnchor.constraint(equalToConstant: Appearance.pageControl)
        ])
    }
}
