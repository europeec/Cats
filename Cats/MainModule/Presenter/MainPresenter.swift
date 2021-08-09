//
//  Presenter.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func show()
}

protocol MainViewPresenterProtocol: AnyObject {
    var cats: []
}
