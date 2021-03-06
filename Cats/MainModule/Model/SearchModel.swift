//
//  SearchModel.swift
//  Cats
//
//  Created by Дмитрий Юдин on 09.08.2021.
//

import UIKit

// swiftlint:disable all
struct SearchModel: Decodable {
    var breeds: [BreedsModel]
    var id: String
    var url: String
    var width: Int
    var height: Int
}
// swiftlint:enable all
