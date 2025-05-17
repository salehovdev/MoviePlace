//
//  TrendingViewModel.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 22.05.25.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
}

//Sort Option
enum SortOption {
    case rating
    case year
}

class MoviesViewModel: ObservableObject {
    
    @Published var popularMovies: [MovieModel] = []
    @Published var upcomingMovies: [MovieModel] = []
    @Published var topRatedMovies: [MovieModel] = []
    
    //Filtered
    @Published var filteredPopularMovies: [MovieModel] = []
    @Published var filteredTopRatedMovies: [MovieModel] = []
    @Published var filteredUpcomingMovies: [MovieModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPopularMovies()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getTopRatedMovies()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.getUpcomingMovies()
        }
    }
    
    //Sort functions
    func sortMovies(_ category: MovieCategory, by option: SortOption) {
        switch category {
        case .popular:
            filteredPopularMovies = sort(movies: popularMovies, by: option)
        case .topRated:
            filteredTopRatedMovies = sort(movies: topRatedMovies, by: option)
        case .upcoming:
            filteredUpcomingMovies = sort(movies: upcomingMovies, by: option)
        }
    }
    
    private func sort(movies: [MovieModel], by option: SortOption) -> [MovieModel] {
        switch option {
        case .rating:
            return movies.sorted { $0.voteAverage > $1.voteAverage }
        case .year:
            return movies.sorted { $0.releaseDate > $1.releaseDate }
        }
    }
    
    func getPopularMovies() {
        guard let url = URL(string: URLs.Endpoints.popularMovies) else {
            return print("Invalid Url")
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error fetching movies:", error.localizedDescription)
                }
            }, receiveValue: { [weak self] movies in
                self?.popularMovies = movies
                self?.filteredPopularMovies = movies
            })
            .store(in: &cancellables)
    }
    
    func getUpcomingMovies() {
        guard let url = URL(string: URLs.Endpoints.upcomingMovies) else {
            return print("Invalid Url")
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error fetching movies:", error.localizedDescription)
                }
            }, receiveValue: { [weak self] movies in
                self?.upcomingMovies = movies
                self?.filteredUpcomingMovies = movies
            })
            .store(in: &cancellables)
    }
    
    func getTopRatedMovies() {
        guard let url = URL(string: URLs.Endpoints.topRatedMovies) else {
            return print("Invalid Url")
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error fetching movies:", error.localizedDescription)
                }
            }, receiveValue: { [weak self] movies in
                self?.topRatedMovies = movies
                self?.filteredTopRatedMovies = movies
            })
            .store(in: &cancellables)
    }
}
