//
//  Router.swift
//  Cats
//
//  Created by Дмитрий Юдин on 10.08.2021.
//

import UIKit

protocol RouterMainProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
    func initialMainViewController()
    func initialFavouriteViewController()
}

protocol RouterProtocol: RouterMainProtocol {
    func showDetail(cat: Cat)
    func showFavouriteDetail(catEntity: CatsEntity)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialMainViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func initialFavouriteViewController() {
        if let navigationController = navigationController {
            guard let favouriteViewController = builder?.createFavouriteModule(router: self) else { return }
            navigationController.viewControllers = [favouriteViewController]
        }
    }
    
    func showDetail(cat: Cat) {
        if let navigationController = navigationController {
            guard let detailViewController = builder?.createDetailModule(with: cat, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func showFavouriteDetail(catEntity: CatsEntity) {
        if let navigationController = navigationController {
            guard let detailFavouriteViewController = builder?.createDetailFavouriteModule(with: catEntity, router: self) else { return }
            navigationController.pushViewController(detailFavouriteViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
