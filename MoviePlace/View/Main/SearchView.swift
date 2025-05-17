//
//  PopularView.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 18.05.25.
//

import SwiftUI

struct SearchView: View {
    @StateObject var movieViewModel = MoviesViewModel()
    
    @State private var showDetail = false
    @State private var selectedMovie: MovieModel?
    
    @Namespace var animation
    
    //Search
    @State private var isSearching = false
    @State private var searchText = ""
    
    var filteredMovies: [MovieModel] {
        if searchText.isEmpty {
            return []
        } else {
            let allMovies = movieViewModel.topRatedMovies + movieViewModel.popularMovies + movieViewModel.upcomingMovies
            let uniqueMovies = Array(Set(allMovies))
            return uniqueMovies.filter { $0.title.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    if isSearching {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Search movies...", text: $searchText)
                                .textFieldStyle(.plain)
                            
                            Button {
                                withAnimation {
                                    isSearching = false
                                    searchText = ""
                                }
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(.gray.opacity(0.8))
                        .cornerRadius(10)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    } else {
                        Button {
                            withAnimation {
                                isSearching = true
                            }
                        } label: {
                            Circle()
                                .fill(.gray.opacity(0.8))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.white)
                                )
                        }
                        .transition(.scale)
                    }
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(filteredMovies) { movie in
                            MovieCardMiniView(movie)
                                .onTapGesture {
                                    selectedMovie = movie
                                    showDetail = true
                                }
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(.searchBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Search")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
            .overlay {
                if let selectedMovie, showDetail {
                    MovieDetailView(showDetail: $showDetail, animation: animation, movie: selectedMovie)
                }
            }
        }
    }
    
    @ViewBuilder
    private func MovieCardMiniView(_ movie: MovieModel) -> some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: URLs.Endpoints.tmdbImagePath(movie.posterPath))) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 4)
            } placeholder: {
                ProgressView()
            }
            .padding(.trailing, 10)

            VStack(alignment: .leading, spacing: 10) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(3)

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
    }
}

#Preview {
    SearchView()
}
