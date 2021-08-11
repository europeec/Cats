//
//  DetailFavouriteViewController.swift
//  Cats
//
//  Created by Дмитрий Юдин on 11.08.2021.
//

import UIKit
class DetailFavouriteViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var favoutireButton: UIButton!
    
    var presenter: DetailFavouriteViewPresenterProtocol!
    var isFavourite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        show()
    }
    
    @IBAction func download(_ sender: Any) {
        presenter.download()
    }
    
    @IBAction func favourite(_ sender: Any) {
        presenter.deleteCat()
        presenter.popToRoot()
    }
}

extension DetailFavouriteViewController: DetailViewProtocol {
    func show() {
        DispatchQueue.main.async { [weak self] in
            let image = self?.presenter.cat?.image
            self?.imageView.image = image
        }
    }
}
