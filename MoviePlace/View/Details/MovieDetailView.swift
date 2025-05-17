//
//  TrendingDetailView.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 18.05.25.
//

import SwiftUI
import SwiftData

struct MovieDetailView: View {
    @Binding var showDetail: Bool
    
    var animation: Namespace.ID
    var movie: MovieModel
    
    @State private var animateContent: Bool = false
    @State private var offsetAnimation: Bool = false
    @State private var isInWatchlist: Bool = false
    
    //SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var watchlistModel: [WatchlistModel]
    
    var body: some View {
        VStack(spacing: 15) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    offsetAnimation = false
                }
                withAnimation(.easeInOut(duration: 0.35).delay(0.1)) {
                    animateContent = false
                    showDetail = false
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .contentShape(Rectangle())
            }
            .padding([.leading, .vertical], 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(animateContent ? 1 : 0)
            
            MovieDetailHeaderView(offsetAnimation: $offsetAnimation, movie: movie, animation: animation)
            .frame(width: 400)
            .zIndex(1)
            
            Rectangle()
                .fill(.gray.opacity(0.04))
                .ignoresSafeArea()
                .overlay(alignment: .top, content: {
                    MovieDetails()
                })
                .padding(.leading, 30)
                .padding(.top, -180)
                .zIndex(0)
                .opacity(animateContent ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(.black)
                .ignoresSafeArea()
                .opacity(animateContent ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35)) {
                animateContent = true
            }
            withAnimation(.easeInOut(duration: 0.35).delay(0.1)) {
                offsetAnimation = true
            }
            isInWatchlist = watchlistModel.contains { $0.id == movie.id }
        }
    }
    
    @ViewBuilder
    private func MovieDetails() -> some View {
        VStack(spacing: 0) {
            // Buttons
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 175, height: 55)
                        .foregroundStyle(.blue.opacity(0.7))
                        .overlay {
                            Label("Play tutorial", systemImage: "play.fill")
                                .foregroundStyle(.white)
                        }
                        .shadow(color: .gray, radius: 5)
                    
                    
                }
                .frame(maxWidth: .infinity)
                
                Button {
                    if isInWatchlist {
                        //Remove
                        if let removeMovie = watchlistModel.first(where: { $0.id == movie.id }) {
                            modelContext.delete(removeMovie)
                            try? modelContext.save()
                            isInWatchlist = false
                        }
                    } else {
                        //Add
                        let newMovie = WatchlistModel(
                            id: movie.id,
                            title: movie.title,
                            posterPath: movie.posterPath,
                            voteAverage: movie.voteAverage,
                            overview: movie.overview,
                            releaseDate: movie.releaseDate,
                            voteCount: movie.voteCount
                        )
                        modelContext.insert(newMovie)
                        try? modelContext.save()
                        isInWatchlist = true
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 175, height: 55)
                        .foregroundStyle(.gray.opacity(0.1))
                        .overlay {
                            Label(
                                isInWatchlist ? "Remove from Watchlist" : "Add to Watchlist",
                                  systemImage: isInWatchlist ? "bookmark.slash" : "bookmark")
                                .foregroundStyle(.white)
                        }
                        .shadow(color: .gray, radius: 5)
                }
                .padding(.trailing, 15)
                .frame(maxWidth: .infinity)
            }
            
            Divider()
                .background(.gray)
                .padding(.top, 25)
            
            // Movie story
            VStack(spacing: 10) {
                Text("Storyline")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 15)
                ScrollView(.vertical, showsIndicators: false) {
                    Text("\(movie.overview)")
                        .font(.headline)
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(.top, 120)
        .offset(y: offsetAnimation ? 0 : 100)
        .opacity(offsetAnimation ? 1 : 0)
    }
}



#Preview {
    PopularMoviesView()
}
