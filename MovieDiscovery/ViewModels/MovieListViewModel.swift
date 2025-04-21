//
//  MovieListViewModel.swift
//  MovieDiscovery
//
//  Created by Bhautik Parmar on 21/04/25.
//

import Foundation

class MovieListViewModel {
    
    private let apiService: APIServiceProtocol

        init(apiService: APIServiceProtocol = APIService()) {
            self.apiService = apiService
        }
    
//    private let apiService = APIService()

    var movies: [Movie] = []
    var onMoviesUpdated: (() -> Void)?
    var onLoadingChanged: ((Bool) -> Void)?
    var onError: ((String) -> Void)?

    func searchMovies(query: String) {
        onLoadingChanged?(true)

        apiService.fetchMovies(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.onLoadingChanged?(false)

                switch result {
                case .success(let movies):
                    self?.movies = movies
                    self?.onMoviesUpdated?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }

    func loadPopularMovies() {
        onLoadingChanged?(true)

        apiService.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.onLoadingChanged?(false)

                switch result {
                case .success(let movies):
                    self?.movies = movies
                    self?.onMoviesUpdated?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }

    func movie(at index: Int) -> Movie {
        return movies[index]
    }

    var count: Int {
        return movies.count
    }
}
