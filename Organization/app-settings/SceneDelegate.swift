//
//  SceneDelegate.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    /// instantiate uiwindow, so we can connect with the scene delegate object.
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        /// instantiate parentViewController as the root of navigationController
        let home = HomeRouter.createModule()
        /// instantiate navigationController
        let navigationController = NavigationController()
        /// Make parentViewController as the root of viewController
        navigationController.viewControllers = [home]
        
        /// instantiate windowSceneObject
        guard let winScene = (scene as? UIWindowScene) else { return }
        
        /// init winow object
        window = UIWindow(windowScene: winScene)
        /// make the window rootViewController with the navigationController
        window?.rootViewController = navigationController
        /// Make the windows as the primary key
        window?.makeKeyAndVisible()
       
        /// instantiate appDelegate Object
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        /// connect app delegate window object with the scene delegate object
        appDelegate.window = self.window
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
    }


}

