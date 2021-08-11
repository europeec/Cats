//
//  FavouritePresenter.swift
//  Cats
//
//  Created by Дмитрий Юдин on 10.08.2021.
//

import UIKit

protocol FavouriteViewProtocol: AnyObject {
    func show()
    func empty()
}

protocol FavouriteViewPresenterProtocol: AnyObject {
    var cats: [Cat]? { get set }
    init(view: FavouriteViewProtocol, router: RouterProtocol, memoryManager: MemoryProtocol)
    func loadCats()
    func tapOnTheCat(cat: Cat)
    func deleteCat()
}

class FavouritePresenter: FavouriteViewPresenterProtocol {
    weak var view: FavouriteViewProtocol?
    var router: RouterProtocol?
    var memory: MemoryProtocol
    var cats: [Cat]?
    
    required init(view: FavouriteViewProtocol, router: RouterProtocol, memoryManager: MemoryProtocol) {
        self.view = view
        self.router = router
        self.memory = memoryManager
        loadCats()
    }
    
    func loadCats() {
        cats = memory.fetch()
    }
    
    func tapOnTheCat(cat: Cat) {
        router?.showDetail(cat: cat)
    }
    
    func deleteCat() {
        
    }
}
