//
//  Cat.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

// MARK: - Cat
struct Cat {
    var image: UIImage
    var breeds: [BreedsModel]
}

// MARK: - Breeds 
struct BreedsModel: Decodable {
    var weight: WeightModel
    var id: String
    var name: String
    var temperament: String
    var country_codes: String
    var country_code: String
    var description: String
    var life_span: String
    var indoor: Int
    var alt_names: String
    var adaptability: Int
    var affection_level: Int
    var child_friendly: Int
    var dog_friendly: Int
    var energy_level: Int
    var grooming: Int
    var health_issues: Int
    var intelligence: Int
    var shedding_level: Int
    var social_needs: Int
    var stranger_friendly: Int
    var vocalisation: Int
    var experimental: Int
    var hairless: Int
    var natural: Int
    var rare: Int
    var rex: Int
    var suppressed_tail: Int
    var short_legs: Int
    var wikipedia_url: String
    var reference_image_id: String
    var origin: String
    
}

struct WeightModel: Decodable {
    var imperial: String
    var metric: String
}
