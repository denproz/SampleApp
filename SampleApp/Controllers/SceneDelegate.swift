//
//  SceneDelegate.swift
//  SampleApp
//
//  Created by Denis Prozukin on 14.07.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		
		let navigationController = UINavigationController(rootViewController: MainViewController())
		window?.rootViewController = navigationController
		
		window?.makeKeyAndVisible()
	}
}

