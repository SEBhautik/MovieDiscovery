//
//  APIServiceProtocol.swift
//  MovieDiscovery
//
//  Created by Bhautik Parmar on 21/04/25.
//

import Foundation

protocol APIServiceProtocol {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], APIError>) -> Void)
    func fetchMovies(query: String, completion: @escaping (Result<[Movie], APIError>) -> Void)
}
