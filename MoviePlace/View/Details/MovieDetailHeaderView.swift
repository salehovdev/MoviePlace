//
//  MovieDetailHeaderView.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 24.05.25.
//

import SwiftUI

struct MovieDetailHeaderView: View {
    @Binding var offsetAnimation: Bool
    
    var movie: MovieModel
    var animation: Namespace.ID
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            
            HStack(spacing: 20) {
                AsyncImage(url: URL(string: URLs.Endpoints.tmdbImagePath(movie.posterPath))) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: (size.width - 30) / 2.3)
                        .clipShape(CustomCorner(corners: [.topRight, .bottomRight], radius: 20))
                        .matchedGeometryEffect(id: movie.id, in: animation)
                        .zIndex(1)
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .frame(width: (size.width - 30) / 2)
                        .clipShape(CustomCorner(corners: [.topRight, .bottomRight], radius: 20))
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(movie.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 50, height: 30)
                            .foregroundStyle(.black)
                            .overlay {
                                Text(yearFromReleaseDate(movie.releaseDate))
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                            .shadow(color: .gray, radius: 5)
                        
                        Text("(\(movie.voteCount))")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                            .padding(.leading, 15)
                    }
                    
                    HStack {
                        Image("imdb")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                        
                        Text("\(movie.voteAverage, specifier: "%.1f") /10")
                            .font(.caption)
                            .padding(.leading, 30)
                    }
                }
                .offset(y: offsetAnimation ? 0 : 100)
                .opacity(offsetAnimation ? 1 : 0)
            }
            .padding(.leading)
        }
        .frame(width: 400)
        .zIndex(1)
    }
    
    func yearFromReleaseDate(_ releaseDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: releaseDate) else {
            return "N/A"
        }
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return String(year)
    }
}

#Preview {
   PopularMoviesView()
}
