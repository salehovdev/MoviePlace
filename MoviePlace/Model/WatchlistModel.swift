//
//  WatchlistModel.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 26.05.25.
//

import Foundation
import SwiftData

@Model
class WatchlistModel: Identifiable {
    @Attribute(.unique) var id: Int
    var title: String
    var posterPath: String
    var voteAverage: Double
    var overview: String
    var releaseDate: String
    var voteCount: Int
    
    init(id: Int, title: String, posterPath: String, voteAverage: Double, overview: String, releaseDate: String, voteCount: Int) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteCount = voteCount
    }
    
}
