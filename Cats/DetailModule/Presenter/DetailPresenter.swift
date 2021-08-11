//
//  DetailPresenter.swift
//  Cats
//
//  Created by Дмитрий Юдин on 10.08.2021.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func show()
}

protocol DetailViewPresenterProtcol: AnyObject {
    var cat: Cat { get set }
    init(view: DetailViewProtocol, router: RouterProtocol, photoService: PhotoProtocol, memory: MemoryProtocol, cat: Cat)
    func download()
    func favourite()
}

class DetailPresenter: DetailViewPresenterProtcol {
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    var photoService: PhotoProtocol?
    var memory: MemoryProtocol?
    var cat: Cat
    
    required init(view: DetailViewProtocol, router: RouterProtocol, photoService: PhotoProtocol, memory: MemoryProtocol, cat: Cat) {
        self.view = view
        self.router = router
        self.photoService = photoService
        self.memory = memory
        self.cat = cat
    }
    
    func download() {
        let image = cat.image
        photoService?.saveImage(image)
    }
    
    func favourite() {
        memory?.save(cat: cat)
    }
}
