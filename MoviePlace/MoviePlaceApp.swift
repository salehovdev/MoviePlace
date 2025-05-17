//
//  MoviePlaceApp.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 17.05.25.
//

import SwiftUI
import SwiftData

@main
struct MoviePlaceApp: App {
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .modelContainer(for: WatchlistModel.self)
    }
}
