//
//  Builder.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createMainModule() -> UIViewController
    func createDetailModule() -> UIViewController
}

class Builder: BuilderProtocol {
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        return view
    }

    func createDetailModule() -> UIViewController {
        <#code#>
    }    
}
