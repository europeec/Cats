//
//  NetworkService.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

protocol NetworkProtocol: AnyObject {
    func loadCats(completion: @escaping (Result<Cat, Error>) -> Void)
    func downloadImageFromUrl(url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class NetworkManager: NetworkProtocol {
    let secretKey = "4f75dd5b-2292-4e33-96dc-45777e3b9158"

    func loadCats(completion: @escaping (Result<Cat, Error>) -> Void) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(secretKey, forHTTPHeaderField: "x-api-key")
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let searchResult = try JSONDecoder().decode([SearchModel].self, from: data)
                let imageUrl = searchResult[0].url
                self.downloadImageFromUrl(url: imageUrl) { result in
                    switch result {
                    case .success(let image):
                        let cat = Cat(image: image, breeds: searchResult[0].breeds)
                        completion(.success(cat))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } catch let decodeError {
                print(String(data: data, encoding: .utf8)!)
                completion(.failure(decodeError))
            }
        }.resume()
    }
    
    func downloadImageFromUrl(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            completion(.success(image))
        }.resume()
    }
}
