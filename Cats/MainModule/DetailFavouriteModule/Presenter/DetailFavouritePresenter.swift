//
//  DetailFavouritePresenter.swift
//  Cats
//
//  Created by Дмитрий Юдин on 11.08.2021.
//

import UIKit

protocol DetailFavouriteViewProtocol: AnyObject {
    func show()
    func confirmDelete()
}

protocol DetailFavouriteViewPresenterProtocol: AnyObject {
    var catEntity: CatsEntity { get set }
    var cat: Cat? { get set }
    init(view: DetailFavouriteViewProtocol, router: RouterProtocol, photoService: PhotoProtocol, catEntity: CatsEntity, cat: Cat, memoryService: MemoryProtocol?)
    func download()
    func favourite()
    func deleteCat()
    func popToRoot()
}

class DetailFavouritePresenter: DetailFavouriteViewPresenterProtocol {
    weak var view: DetailFavouriteViewProtocol?
    var router: RouterProtocol?
    var photoService: PhotoProtocol?
    var memory: MemoryProtocol?
    var catEntity: CatsEntity
    var cat: Cat?
    
    required init(view: DetailFavouriteViewProtocol,
                  router: RouterProtocol,
                  photoService: PhotoProtocol,
                  catEntity: CatsEntity,
                  cat: Cat,
                  memoryService: MemoryProtocol?) {
        self.view = view
        self.router = router
        self.photoService = photoService
        self.catEntity = catEntity
        self.memory = memoryService
        self.cat = cat
    }
    
    func download() {
        let image = cat?.image
        photoService?.saveImage(image)
    }
    
    func favourite() {
        guard let cat = cat else { return }
        memory?.save(cat: cat)
    }
    
    func deleteCat() {
        memory?.remove(catEntity: catEntity)
    }
    
    func popToRoot() {
        router?.popToRoot()
    }
}
