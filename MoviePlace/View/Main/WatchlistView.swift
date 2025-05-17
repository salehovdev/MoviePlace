//
//  WatchlistView.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 19.05.25.
//

import SwiftUI
import SwiftData

struct WatchlistView: View {
    @State private var selectedMovie: MovieModel?
    @State private var showDetail = false
    
    @Namespace var animation
    
    @Environment(\.modelContext) var modelContext
    @Query private var watchlistModel: [WatchlistModel]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(watchlistModel) { movie in
                            MovieRow(movie: movie) {
                                let movies = MovieModel(
                                    id: movie.id,
                                    overview: movie.overview,
                                    title: movie.title,
                                    voteAverage: movie.voteAverage,
                                    releaseDate: movie.releaseDate,
                                    posterPath: movie.posterPath,
                                    voteCount: movie.voteCount
                                )
                                selectedMovie = movies
                                showDetail = true
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .padding(15)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Watchlist")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
            .background(.splashBackground)
            .overlay {
                if let selectedMovie, showDetail {
                    MovieDetailView(showDetail: $showDetail, animation: animation, movie: selectedMovie)
                }
            }
        }
    }
}

//Movie View
struct MovieRow: View {
    let movie: WatchlistModel
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 10) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                
                HStack(spacing: 20) {
                    Image("imdb")
                        .resizable()
                        .frame(width: 30, height: 15)
                    Text("\(movie.voteAverage, specifier: "%.1f") /10")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
        }
        .padding()
        .frame(width: 350, height: 150)
        .background(.black.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    WatchlistView()
}
