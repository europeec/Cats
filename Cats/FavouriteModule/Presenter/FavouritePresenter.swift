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
