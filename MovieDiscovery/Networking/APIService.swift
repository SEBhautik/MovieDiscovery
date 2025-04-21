//
//  APIService.swift
//  MovieDiscovery
//
//  Created by Bhautik Parmar on 21/04/25.
//

enum APIError: Error {
    case invalidURL
    case decodingFailed
    case serverError

    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .decodingFailed: return "Failed to decode data"
        case .serverError: return "Something went wrong. Please try again."
        }
    }
}

import UIKit

class APIService: APIServiceProtocol {
    private let apiKey = "97e08b6b1531968a2d22e35fba37c6d2"
    private let baseURL = "https://api.themoviedb.org/3"

    func fetchMovies(query: String, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/search/movie?query=\(queryEncoded)&api_key=\(apiKey)") else {
            completion(.failure(.invalidURL))
            return
        }

        fetch(url: url, completion: completion)
    }

//    API Endpoint: https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY
//    API for Search: https://api.themoviedb.org/3/search/movie?query={search_term}&api_key=YOUR_API_KEY

    func fetchPopularMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/discover/movie?api_key=\(apiKey)") else {
            completion(.failure(.invalidURL))
            return
        }

        fetch(url: url, completion: completion)
    }

    private func fetch(url: URL, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(.serverError))
                return
            }

            guard let data = data,
                  let response = try? JSONDecoder().decode(MovieResponse.self, from: data) else {
                completion(.failure(.decodingFailed))
                return
            }

            completion(.success(response.results))
        }.resume()
    }
}
