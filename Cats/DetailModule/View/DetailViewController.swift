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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        show()
    }
    
    @IBAction func download(_ sender: Any) {
        presenter.download()
    }
    
    @IBAction func favourite(_ sender: Any) {
        presenter.favourite()
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
