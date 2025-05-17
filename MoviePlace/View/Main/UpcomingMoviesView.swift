//
//  UpcomingMoviesView.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 24.05.25.
//

import SwiftUI

struct UpcomingMoviesView: View {
    @StateObject var movieViewModel = MoviesViewModel()
    
    @State private var showDetail = false
    @State private var selectedMovie: MovieModel?
    
    @Namespace private var animation
    @State private var animateCurrentMovie: Bool = false
    
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 15) {
            //Navigation View
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.trailing, 70)
                }
                
                
                
                Text("Upcoming")
                    .font(.largeTitle.bold())
                
                Spacer()
                
                FilterButton(category: .upcoming) { category, option in
                    movieViewModel.sortMovies(category, by: option)
                }
            }
            .padding()
            
            // Movie Scroll View
            GeometryReader {
                let size = $0.size
                let movies = movieViewModel.filteredUpcomingMovies
                
                ScrollView {
                    VStack(spacing: 25) {
                        ForEach(movies) { movie in
                            GeometryReader { geo in
                                let rect = geo.frame(in: .named("ScrollView"))
                                let rotation = convertOffsetToRotation(rect)

                                MovieCardView(
                                    movie: movie,
                                    animation: animation,
                                    showDetail: showDetail,
                                    animateCurrentMovie: animateCurrentMovie,
                                    selectedMovie: selectedMovie,
                                    rotation: rotation
                                )
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        animateCurrentMovie = true
                                        selectedMovie = movie
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                            showDetail = true
                                        }
                                    }
                                }
                            }
                            .frame(height: 275)
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                    .padding(.bottom, bottomPadding(size))
                }
                .background(.topratedBackground)
                .coordinateSpace(name: "ScrollView")
            }
        }
        .navigationBarBackButtonHidden(true)
        // Movie Detail View
        .overlay {
            if let selectedMovie, showDetail {
                MovieDetailView(showDetail: $showDetail, animation: animation, movie: selectedMovie)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
            }
        }
        .onChange(of: showDetail) { newValue, oldValue in
            if !newValue {
                withAnimation(.easeInOut(duration: 0.15).delay(0.3)) {
                    animateCurrentMovie = false
                }
            }
        }
    }
    
    func convertOffsetToRotation(_ rect: CGRect) -> CGFloat {
        let cardHeight = rect.height + 20
        let minY = rect.minY - 20
        let progress = minY < 0 ? (minY / cardHeight) : 0
        let constrainedProgress = min(-progress, 1.0)
        return constrainedProgress * 90
    }
    
    func bottomPadding(_ size: CGSize = .zero) -> CGFloat {
        let cardHeight: CGFloat = 275
        let scrollViewHeight: CGFloat = size.height
        return scrollViewHeight - cardHeight - 40
    }
}


#Preview {
    UpcomingMoviesView()
}
