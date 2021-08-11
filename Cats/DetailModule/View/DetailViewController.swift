//
//  DetailViewController.swift
//  Cats
//
//  Created by Дмитрий Юдин on 10.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var favoutireButton: UIButton!
    
    var presenter: DetailViewPresenterProtcol!
    var isFavourite = false 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        show()
    }
    
    @IBAction func download(_ sender: Any) {
        presenter.download()
    }
    
    @IBAction func favourite(_ sender: Any) {
        if !isFavourite {
            presenter.favourite()
            updateFavouriteButtonImage()
            isFavourite = true 
        }
    }
    
    func updateFavouriteButtonImage() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.favoutireButton.setImage(self.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        }
    }
}

extension DetailViewController: DetailViewProtocol {
    func show() {
        DispatchQueue.main.async { [weak self] in
            let image = self?.presenter.cat.image
            self?.imageView.image = image
        }
    }
}
