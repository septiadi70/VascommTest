//
//  AppDelegate.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let container: Container = {
        let container = Container()
        container.register(AuthRemoteDataSourceProtocol.self) { _ in
            AuthRemoteDataSource(networkService: NetworkService.shared)
        }
        container.register(AuthRepositoryProtocol.self) { r in
            AuthRepository(remote: r.resolve(AuthRemoteDataSourceProtocol.self)!,
                           keychain: KeychainManager.shared)
        }
        container.register(LoginUseCaseProtocol.self) { r in
            LoginUseCase(repository: r.resolve(AuthRepositoryProtocol.self)!)
        }
        container.register(LoginViewModel.self) { r in
            LoginViewModel(useCase: r.resolve(LoginUseCaseProtocol.self)!)
        }
        container.register(LoginViewController.self) { r in
            LoginViewController(viewModel: r.resolve(LoginViewModel.self)!)
        }
        container.register(RegisterViewController.self) { _ in RegisterViewController() }
        container.register(HomeViewController.self) { _ in HomeViewController() }
        
        container.register(MenuUseCaseProtocol.self) { r in
            MenuUseCase(repository: r.resolve(AuthRepositoryProtocol.self)!)
        }
        container.register(SideMenuViewModel.self) { r in
            SideMenuViewModel(useCase: r.resolve(MenuUseCaseProtocol.self)!)
        }
        container.register(SideMenuViewController.self) { r in
            SideMenuViewController(viewModel: r.resolve(SideMenuViewModel.self)!)
        }
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

