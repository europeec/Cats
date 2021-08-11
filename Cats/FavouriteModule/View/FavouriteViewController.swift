//
//  FavouriteViewController.swift
//  Cats
//
//  Created by Дмитрий Юдин on 11.08.2021.
//

import UIKit

class FavouriteViewController: UIViewController {
    var presenter: FavouriteViewPresenterProtocol!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(FavouriteCollectionViewCell.nib, forCellWithReuseIdentifier: FavouriteCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - View Protocol
extension FavouriteViewController: FavouriteViewProtocol {
    func show() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func empty() {
        
    }
}

// MARK: - CollectionView Protocols
extension FavouriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.cats?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCollectionViewCell.identifier,
                                                            for: indexPath) as? FavouriteCollectionViewCell else { fatalError() }
        
        let cat = presenter.cats?[indexPath.row]
        cell.configure(with: cat?.image)
        return cell
    }
    
    
}

extension FavouriteViewController: UICollectionViewDelegate {
    
}
