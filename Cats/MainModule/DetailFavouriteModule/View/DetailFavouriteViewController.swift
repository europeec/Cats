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
        confirmDelete()
    }
}

extension DetailFavouriteViewController: DetailFavouriteViewProtocol {
    func show() {
        DispatchQueue.main.async { [weak self] in
            let image = self?.presenter.cat?.image
            self?.imageView.image = image
        }
    }
    
    func confirmDelete() {
        let alert = UIAlertController(title: "Удалить?", message: "Вы действительно хотите удалить этого котика из избранных?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { [weak self] _ in
            self?.presenter.deleteCat()
            self?.presenter.popToRoot()
        }))
        alert.addAction(UIAlertAction(title: "Нет!", style: .cancel))
        self.present(alert, animated: true)
    }
}
