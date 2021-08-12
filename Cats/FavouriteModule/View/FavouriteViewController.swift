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
        title = "Избранное"
        
        collectionView.register(FavouriteCollectionViewCell.nib, forCellWithReuseIdentifier: FavouriteCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.loadCats()
        show()
        if presenter.isEmpty { empty() }
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
        let alert = UIAlertController(title: "Тут никого нет..", message: "Добавьте котиков в избранное", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okks..", style: .default))
        self.present(alert, animated: true)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cat = presenter.catsEntity![indexPath.row]
        presenter.tapOnTheCat(cat: cat)
    }
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = UIScreen.main.bounds.size.width
        return CGSize(width: side, height: side)
    }
}
