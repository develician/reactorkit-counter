//
//  AppDelegate.swift
//  ReactorKit Sample
//
//  Created by killi8n on 2018. 8. 25..
//  Copyright © 2018년 killi8n. All rights reserved.
//

import UIKit
import ReactorKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = CounterViewController()

        return true
    }



}

