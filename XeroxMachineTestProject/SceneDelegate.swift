//
//  SceneDelegate.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 19/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.rootViewHandler(scene)
    }
        
    func rootViewHandler(_ windowScene: UIWindowScene){
        NetworkManager.shared.startMonitor()
        let loginModel = LoginViewModel()
        loginModel.onLogout = { [weak self] in
            self?.navigateTo(windowScene: windowScene, login: false)
        }
        loginModel.isAlreadyUsedSignedIn { signin in
            if(signin){
                self.navigateTo(windowScene: windowScene, login: signin)
            }
            else{
                self.navigateTo(windowScene: windowScene, login: false)
            }
        }
    }
    
    func navigateTo(windowScene: UIWindowScene, login: Bool){
        DispatchQueue.main.async {
            let viewController: UINavigationController
            self.window = UIWindow(windowScene: windowScene)
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            if(login){
                let vc = mainStoryBoard.instantiateViewController(identifier: "DeviceListViewController") as! DeviceListViewController
                let navController = UINavigationController(rootViewController: vc)
                navController.navigationBar.isHidden = true
                viewController = navController
            }
            else{
                let vc = mainStoryBoard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                let navController = UINavigationController(rootViewController: vc)
                navController.navigationBar.isHidden = true
                viewController = navController
            }
            viewController.navigationBar.isHidden = true
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
            UIView.transition(with: self.window!, duration: 0.5, options: [], animations: {
            }, completion: nil)
        }
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
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

