//
//  MainPresenter.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func loading()
    func success()
    func failure()
}

protocol MainViewPresenterProtocol: AnyObject {
    var cats: [Cat]? { get set }
    init(view: MainViewProtocol, networkManager: NetworkProtocol)
    func loadCats()
    func tapOnTheCat(cat: Cat)
    func reloadData()
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var networkManager: NetworkProtocol
    var cats: [Cat]?
    
    required init(view: MainViewProtocol, networkManager: NetworkProtocol) {
        self.view = view
        self.networkManager = networkManager
        loadCats()
    }
    
    func loadCats() {
        view?.loading()
        
        networkManager.getCats { [weak self] result in
            // strong self
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let cats):
                    self.cats = cats
                    self.view?.success()
                case .failure(_):
                    self.view?.failure()
                }
            }
        }
    }
    
    func tapOnTheCat(cat: Cat) {
        print(cat)
    }
    
    func reloadData() {
        loadCats()
    }
}
