//
//  MockAPIService.swift
//  MovieDiscovery
//
//  Created by Bhautik Parmar on 21/04/25.
//
import Foundation

class MockAPIService: APIServiceProtocol {
    var mockResult: Result<[Movie], APIError>?

    func fetchPopularMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        if let result = mockResult {
            completion(result)
        } else {
            let movies = loadMockMovies()
            completion(.success(movies))
        }
    }

    func fetchMovies(query: String, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        if let result = mockResult {
            completion(result)
        } else {
            let movies = loadMockMovies().filter { $0.title.lowercased().contains(query.lowercased()) }
            completion(.success(movies))
        }
    }
    
    func loadMockMovies() -> [Movie] {
        guard let url = Bundle(for: type(of: self)).url(forResource: "MockMovies", withExtension: "json"), let data = try? Data(contentsOf: url) else {
            print("Failed to load MockMovies.json")
            return []
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let moviesResponse = try decoder.decode(MovieResponse.self, from: data)
            return moviesResponse.results
        } catch {
            print("JSON decode error: \(error)")
            return []
        }
    }
}
