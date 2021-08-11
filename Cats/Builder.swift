//
//  Builder.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(with cat: Cat, router: RouterProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(view: view, router: router, networkManager: networkManager)
        view.presenter = presenter
        return view
    }

    func createDetailModule(with cat: Cat, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let photoService = PhotoService()
        let presenter = DetailPresenter(view: view, router: router, photoService: photoService, cat: cat)
        view.presenter = presenter
        return view
    }    
}
