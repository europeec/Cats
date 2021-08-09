//
//  CatCollectionViewCell.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {

    static let identifier = "CatCollectionViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favouriteView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage, isFavourite: Bool) {
        imageView.image = image
        // todo: favourite
    }
}
