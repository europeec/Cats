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
    var updating = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cats"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload))
        
        collectionView.register(CatCollectionViewCell.nib, forCellWithReuseIdentifier: CatCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        let size = view.frame.size.width / 2 - 13
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        collectionView.collectionViewLayout = layout
    }
    
    @objc func reload() {
        if !updating {
            presenter.reloadData()
            updating = true
        }
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.updating {
                for subview in self.view.subviews {
                    let activity = subview as? UIActivityIndicatorView
                    if activity != nil {
                        subview.removeFromSuperview()
                    }
                }
                self.updating = false
                self.collectionView.isHidden = false
            }
            self.collectionView.reloadData()
        }
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cats = presenter.cats else { return }
        if indexPath.row == cats.count - 6 {
            presenter.addMoreData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cat = presenter.cats?[indexPath.row] else { return }
        presenter.tapOnTheCat(cat: cat)
    }
}
