//
//  AppDelegate.swift
//  ContactApp
//
//  Created by Ilshat Khairakhun on 03.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let viewController = ViewController()
        window?.rootViewController = viewController
        
        return true
    }

}

