//
//  FavouriteCollectionViewCell.swift
//  Cats
//
//  Created by Дмитрий Юдин on 11.08.2021.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {
    static let identifier = "FavouriteCollectionViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(with image: UIImage?) {
        guard let image = image else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = image
        }
    }
}
