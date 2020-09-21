//
//  AppDelegate.swift
//  GovermentServices
//
//  Created by Holyberry on 20.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let initializer = HotWaterShutoffModuleInitializer()
        let navigationController = UINavigationController(rootViewController: initializer.hotwatershutoffViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

