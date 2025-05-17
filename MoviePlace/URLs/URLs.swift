//
//  Constants.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 17.05.25.
//

import Foundation

struct URLs {
    
    struct APIKeys {
        static let tmdbKey = "383d8029d3ef8ba0d07d2ddd830ca760"
    }

    struct BaseURLs {
        static let tmdb = "https://api.themoviedb.org/3"
        static let tmdbImage = "https://image.tmdb.org/t/p/w500"
    }

    struct Endpoints {
        // TMDB
        static let popularMovies = "\(BaseURLs.tmdb)/movie/popular?api_key=\(APIKeys.tmdbKey)"
        static let upcomingMovies = "\(BaseURLs.tmdb)/movie/upcoming?api_key=\(APIKeys.tmdbKey)"
        static let topRatedMovies = "\(BaseURLs.tmdb)/movie/top_rated?api_key=\(APIKeys.tmdbKey)"
        static let playingNowMovies = "\(BaseURLs.tmdb)/movie/now_playing?api_key=\(APIKeys.tmdbKey)"

        static func tmdbImagePath(_ path: String) -> String {
            return "\(BaseURLs.tmdbImage)\(path)"
        }
    }
}
