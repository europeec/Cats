//
//  Builder.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createMainModule() -> UIViewController
}

class Builder: BuilderProtocol {
    func createMainModule() -> UIViewController {
        let view = MainViewController()
    }
}
