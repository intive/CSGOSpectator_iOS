//
//  AppDelegate.swift
//  CSGOSpectator
//
//  Created by Mateusz Fidos on 03.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setCustomizing()
        return true
    }
    
    func setCustomizing() {
        UITableViewCell.appearance().backgroundColor = .clear
        UITabBar.appearance().tintColor = .white
    }

}
