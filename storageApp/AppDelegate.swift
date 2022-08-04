//
//  AppDelegate.swift
//  storageApp
//
//  Created by Ffhh Qerg on 25.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarVC = UITabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarVC
        
       
        let firstVC = LoginViewController()
        let firstNavController = UINavigationController(rootViewController: firstVC)
        
        firstVC.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(named: "habits"), tag: 0)
        
        
        
   
        
        
        tabBarVC.viewControllers = [firstNavController]
        return true
    }

    


}

