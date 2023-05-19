//
//  AppDelegate.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 17.04.2023.
//

import UIKit

var di = Di()

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        if di.authorizationService.isLogIn() {
            window?.rootViewController = UINavigationController(rootViewController: di.screenFactory.makeMarketScreen())
            window?.makeKeyAndVisible()
        } else {
            window?.rootViewController = di.screenFactory.makeOnboardingScreen()
            window?.makeKeyAndVisible()
        }
    }
    
    // MARK: Lock Orientation
    private let orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
}
