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
    init(view: DetailViewProtocol, photoService: PhotoProtocol, cat: Cat)
    func download()
    func favourite()
}

class DetailPresenter: DetailViewPresenterProtcol {
    weak var view: DetailViewProtocol?
    var photoService: PhotoProtocol?
    var cat: Cat
    
    required init(view: DetailViewProtocol, photoService: PhotoProtocol, cat: Cat) {
        self.view = view
        self.photoService = photoService
        self.cat = cat
    }
    
    func download() {
        let image = cat.image
        photoService?.saveImage(image)
    }
    
    func favourite() {
        
    }
    
}
