//
//  SceneDelegate.swift
//  ProjectionTest
//
//  Created by Mykhailo Glagola on 10.10.2022.
//

import UIKit
import AppAbsoluteFrame

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appFrameListener: AppFrameListener?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        
        let appFrameListener = AppFrameListener(scene: windowScene, window: window)
        setRootViewController(window: window, appFrameListener: appFrameListener)
        
        self.window = window
        self.appFrameListener = appFrameListener
    }
    
    private func setRootViewController(window: UIWindow, appFrameListener: AppFrameListener) {
        let deviceHasHomeButton = UIDevice.current.hasHomeButton ?? (window.safeAreaInsets.bottom == 0)
        switch deviceHasHomeButton {
        case true:
            window.rootViewController = PadContainerViewController<iPadWithHomeButtonViewController>(appFrameListener)
        case false:
            window.rootViewController = PadContainerViewController<ModedrIPadViewController>(appFrameListener)
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        appFrameListener?.startListening()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        appFrameListener?.stopListening()
    }
    
    
}

