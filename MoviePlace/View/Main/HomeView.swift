//
//  HomeView.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 18.05.25.
//

import SwiftUI

enum MovieCategory: Identifiable {
    case popular, topRated, upcoming
    
    var id: String {
        switch self {
        case .popular: return "popular"
        case .topRated: return "topRated"
        case .upcoming: return "upcoming"
        }
    }
}

struct HomeView: View {
    @StateObject var trendingViewModel = MoviesViewModel()
    
    @State private var selectedCategory: MovieCategory?
    @State private var showDetail = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.homeBackground)
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    horizontalTrendingView(text: "Trending Now",category: .popular, movies: trendingViewModel.popularMovies)
                    horizontalTrendingView(text: "Top Movies",category: .topRated, movies: trendingViewModel.topRatedMovies)
                    horizontalTrendingView(text: "Upcoming", category: .upcoming, movies: trendingViewModel.upcomingMovies)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("MoviePlace")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
            .navigationDestination(item: $selectedCategory) { category in
                switch category {
                case .popular:
                    PopularMoviesView()
                case .topRated:
                    TopMoviesView()
                case .upcoming:
                    UpcomingMoviesView()
                }
            }
        }
    }
    
    private func horizontalTrendingView(text: String, category: MovieCategory, movies: [MovieModel]) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(text)
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    selectedCategory = category
                } label: {
                    Text("View all")
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movies) { movie in
                        AsyncImage(url: URL(string: URLs.Endpoints.tmdbImagePath(movie.posterPath))) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 150, height: 250)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(.gray, lineWidth: 1)
                                    }
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 250)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
