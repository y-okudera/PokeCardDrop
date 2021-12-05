//
//  SceneDelegate.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/05.
//

import UIKit
import Toast

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // アプリ未起動時にAirDrop受け取りから起動した場合
        if let urlContext = connectionOptions.urlContexts.first {
            print("urlContext.url", urlContext.url)
            do {
                let receivedData = try Data(contentsOf: urlContext.url)
                let receivedPokeCard: PokeCard = Decoder.jsonDecode(from: receivedData)
                let receivedPokeCardRepository = ReceivedPokeCardRepositoryProvider.provide()
                receivedPokeCardRepository.write(receivedPokeCard: receivedPokeCard)
            } catch {
                print("data is nil. fromUrl: \(urlContext.url.path)")
                return
            }
        }

        setupWindow(windowScene: (scene as? UIWindowScene))
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

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print(#function)
        open(urlContexts: URLContexts)
    }
}

// MARK: - Private
extension SceneDelegate {

    private func setupWindow(windowScene: UIWindowScene?) {
        guard let windowScene = windowScene else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.makeKeyAndVisible()

        let vc = PokeCardListViewController.build(pokeCards: AssetLoader.loadWithDecode(name: "cards"))
        let navigation = UINavigationController(rootViewController: vc)

        window.rootViewController = navigation
    }

    private func open(urlContexts: Set<UIOpenURLContext>) {
        guard let urlContext = urlContexts.first else {
            return
        }
        do {
            print("urlContext.url", urlContext.url)
            let receivedData = try Data(contentsOf: urlContext.url)
            let receivedPokeCard: PokeCard = Decoder.jsonDecode(from: receivedData)

            if let frontVC = UIViewController.getFrontViewController() {
                let vc = PokeCardDetailViewController.build(pokeCard: receivedPokeCard)
                frontVC.present(vc, animated: true, completion: {
                    vc.view.makeToast("Received \(receivedPokeCard.name) via AirDrop.", position: .top)
                })
            }
        } catch {
            print("data is nil. fromUrl: \(urlContext.url.path)")
            return
        }
    }
}
