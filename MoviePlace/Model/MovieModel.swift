//
//  Popular.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 18.05.25.
//

import Foundation
import SwiftUI

struct MovieResponse: Codable {
    let results: [MovieModel]
}

struct MovieModel: Codable, Identifiable, Hashable {
    let id: Int
    let overview: String
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let posterPath: String
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteCount = "vote_count"
    }
}


    
    



