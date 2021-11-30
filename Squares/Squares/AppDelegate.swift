//
//  AppDelegate.swift
//  Squares
//
//  Created by mac on 25.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let landingController = LandingViewController.loadFromNib()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = landingController
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}

