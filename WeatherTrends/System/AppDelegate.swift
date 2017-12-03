//
//  AppDelegate.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/29/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        App.setNetworkService(NetworkManager())
        App.setWeatherService(WeatherManager())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let rootVC = DataTypesViewControllerFactory.makeHomeNavigationController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        return true
    }

}

