//
//  Builder.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailFavouriteModule(with catEntity: CatsEntity,
                            router: RouterProtocol) -> UIViewController
    func createDetailModule(with cat: Cat, router: RouterProtocol) -> UIViewController
    func createFavouriteModule(router: RouterProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
    func createDetailFavouriteModule(with catEntity: CatsEntity, router: RouterProtocol) -> UIViewController {
        let view = DetailFavouriteViewController()
        let photo = PhotoService()
        let memory = MemoryService.shared
        let cat = memory.convert(entity: catEntity)!
        let presenter = DetailFavouritePresenter(view: view,
                                                 router: router,
                                                 photoService: photo,
                                                 catEntity: catEntity,
                                                 cat: cat,
                                                 memoryService: memory)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(with cat: Cat, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let photo = PhotoService()
        let memory = MemoryService.shared
        let presenter = DetailPresenter(view: view, router: router,
                                        photoService: photo,
                                        memory: memory,
                                        cat: cat)
        view.presenter = presenter
        return view
    }
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(view: view, router: router, networkManager: networkManager)
        view.presenter = presenter
        return view
    }

    func createFavouriteModule(router: RouterProtocol) -> UIViewController {
        let view = FavouriteViewController()
        let memory = MemoryService()
        let presenter = FavouritePresenter(view: view, router: router, memoryManager: memory)
        view.presenter = presenter
        return view
    }
}
