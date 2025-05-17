//
//  ContentView.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 19.05.25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            WatchlistView()
                .tabItem {
                    Label("Watchlist", systemImage: "movieclapper")
                }
        }
        .tint(.primary)
    }
}

#Preview {
    ContentView()
}
