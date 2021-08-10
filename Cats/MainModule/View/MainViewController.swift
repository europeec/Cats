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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload))
        
        collectionView.register(CatCollectionViewCell.nib, forCellWithReuseIdentifier: CatCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 200)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3

        collectionView.collectionViewLayout = layout
    }
    
    @objc func reload() {
        presenter.reloadData()
    }
}

// MARK: - Main View Protocol
extension MainViewController: MainViewProtocol {
    func loading() {
        collectionView?.isHidden = true
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
    }
    
    func success() {
        for subview in view.subviews {
            if subview as? UIActivityIndicatorView != nil {
                subview.removeFromSuperview()
            }
        }
        collectionView.isHidden = false
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
        
        let image = presenter.cats?[indexPath.row].image
        cell.configure(with: image, isFavourite: false)
        return cell 
    }
    
    
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cat = presenter.cats?[indexPath.row] else { return }
        presenter.tapOnTheCat(cat: cat)
    }
}

