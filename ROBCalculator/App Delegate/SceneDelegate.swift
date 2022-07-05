//
//  SceneDelegate.swift
//  ROBCalculator
//
//  Created by arkhyp on 22.02.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var injectionContainer = AppContainer()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupTabBar()
        setupNavigationBar()
        
//        let tmpC = SignedInContainer(appContainer: injectionContainer)
//        let mainVC = tmpC.makeCalculationNavigationViewMOC()//injectionContainer.makeMainViewController()
        
        let mainVC = injectionContainer.makeMainViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        (UIApplication.shared.delegate as? AppDelegate)?.window = window
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .appBackground
        tabBarAppearance.shadowColor = .clear
        
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColor]
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = titleAttributes
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = titleAttributes
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .appBlue
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .appBlue
        
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance.copy()
        
        tabBarAppearance.shadowImage = UIImage(named: "tabShadow")?.withRenderingMode(.alwaysTemplate)
        tabBarAppearance.shadowColor = .appBackground
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().tintColor = .appBlue
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .appBackground
        navBarAppearance.shadowColor = .appBackground
        navBarAppearance.shadowImage = UIImage(named: "navShadow")?.withRenderingMode(.alwaysTemplate)
        UINavigationBar.appearance().standardAppearance = navBarAppearance.copy()
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}
