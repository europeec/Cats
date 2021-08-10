//
//  PhotoService.swift
//  Cats
//
//  Created by Дмитрий Юдин on 10.08.2021.
//

import UIKit

protocol PhotoProtocol: AnyObject {
    func saveImage(_ image: UIImage?)
}

class Photo: PhotoProtocol {
    func saveImage(_ image: UIImage?) {
        guard let image = image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
