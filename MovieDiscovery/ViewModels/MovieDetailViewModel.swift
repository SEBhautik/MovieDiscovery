//
//  MovieDetailViewModel.swift
//  MovieDiscovery
//
//  Created by Bhautik Parmar on 21/04/25.
//

import Foundation

import Foundation

class MovieDetailViewModel {
    private let movie: Movie

    var onImageLoadStarted: (() -> Void)?
    var onImageLoadFinished: (() -> Void)?
    var onImageLoadFailed: ((String) -> Void)?

    init(movie: Movie) {
        self.movie = movie
    }

    var title: String {
        return movie.title
    }

    var overview: String {
        return movie.overview
    }

    var releaseDate: String {
        return movie.releaseDate ?? "N/A"
    }

    var posterURL: URL? {
        guard let path = movie.posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
