//
//  MovieCardView.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 24.05.25.
//

import SwiftUI

struct MovieCardView: View {
    var movie: MovieModel
    var animation: Namespace.ID
    var showDetail: Bool
    var animateCurrentMovie: Bool
    var selectedMovie: MovieModel?

    var rotation: CGFloat

    var body: some View {
        GeometryReader { geo in
            let size = geo.size

            HStack(spacing: -10) {
                // Movie Detail Card
                VStack(alignment: .leading, spacing: 6) {
                    Text(movie.title)
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontWeight(.semibold)

                    HStack {
                        Image("imdb")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)

                        Text("\(movie.voteAverage, specifier: "%.1f") /10")
                            .foregroundStyle(.white.opacity(0.7))
                            .padding(.leading, 25)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .padding(.top)

                    HStack {
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.trailing)
                    }
                    .padding(.top, 30)
                }
                .padding(20)
                .frame(width: size.width / 2, height: size.height * 0.8)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.black.opacity(0.7))
                        .shadow(color: .white.opacity(0.12), radius: 8, x: 5, y: 5)
                        .shadow(color: .white.opacity(0.12), radius: 8, x: -5, y: -5)
                }
                .offset(x: animateCurrentMovie && selectedMovie?.id == movie.id ? -20 : 0)

                // Movie Image
                ZStack {
                    if !(showDetail && selectedMovie?.id == movie.id) {
                        AsyncImage(url: URL(string: URLs.Endpoints.tmdbImagePath(movie.posterPath))) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: size.width / 2, height: size.height)
                                .clipShape(.rect(cornerRadius: 10))
                                .matchedGeometryEffect(id: movie.id, in: animation)
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                                .zIndex(1)
                        } placeholder: {
                            ProgressView()
                                .frame(width: size.width / 2, height: size.height)
                        }
                    }
                }
            }
            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 0, z: 0), anchor: .bottom, anchorZ: 1, perspective: 0.7)
        }
        .frame(height: 275)
    }
}

#Preview {
    PopularMoviesView()
}
