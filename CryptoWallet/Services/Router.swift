//
//  Router.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 10.05.2023.
//

import UIKit

protocol Router {
    func showCoinScreen(_ coin: Coin, from: UIViewController)
    func showMarketScreen()
    func showLoginScreen()
    func logOut()
}

final class RouterImpl: Router {
    
    func showCoinScreen(_ coin: Coin, from: UIViewController) {
        let coinVC = di.screenFactory.makeCoinScreen(coin: coin)
        from.navigationController?.pushViewController(coinVC, animated: true)
    }
    
    func showMarketScreen() {
        let marketVC = di.screenFactory.makeMarketScreen()
        let new = UINavigationController(rootViewController: marketVC)
        replaceRootViewControllerWith(new, animated: true)
    }
    
    func showLoginScreen() {
        let LoginVC = di.screenFactory.makeLoginScreen()
        let new = UINavigationController(rootViewController: LoginVC)
        replaceRootViewControllerWith(new, animated: true)
    }
    
    func logOut() {
        let OnboardingVC = di.screenFactory.makeOnboardingScreen()
        let new = UINavigationController(rootViewController: OnboardingVC)
        replaceRootViewControllerWith(new, animated: true)
    }
    
    func replaceRootViewControllerWith(_ newRootViewController: UIViewController, animated: Bool) {
        guard let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first else { return }
        
        newRootViewController.beginAppearanceTransition(true, animated: animated)
        
        if animated {
            window.addSubview(newRootViewController.view)
            
            newRootViewController.view.alpha = 0
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.fade
            
            window.layer.add(transition, forKey: nil)
            
            UIView.animate(withDuration: 0.3, animations: {
                newRootViewController.view.alpha = 1
                
            }, completion: { _ in
                window.rootViewController?.view.removeFromSuperview()
                window.rootViewController = newRootViewController
            })
        } else {
            window.rootViewController = newRootViewController
        }
    }
}
