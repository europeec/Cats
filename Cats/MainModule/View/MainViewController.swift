//
//  MainViewController.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    var presenter: MainViewPresenterProtocol!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cats"
        
        collectionView.register(CatCollectionViewCell.nib, forCellWithReuseIdentifier: CatCollectionViewCell.identifier)
    }
}

// MARK: - Main View Protocol
extension MainViewController: MainViewProtocol {
    func show() {
        collectionView.reloadData()
    }
    
    func failure() {
        print("error")
    }
}

// MARK: - Collection View Protocols
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.cats?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCollectionViewCell.identifier, for: indexPath) as? CatCollectionViewCell else { fatalError() }
        
        cell.imageView.image = presenter.cats?[indexPath.row].image
        return cell 
    }
    
    
}

extension MainViewController: UICollectionViewDelegate {
    
}
