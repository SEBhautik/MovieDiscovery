//
//  MovieListViewModelTests.swift
//  MovieDiscovery
//
//  Created by Bhautik Parmar on 21/04/25.
//

import XCTest
@testable import MovieDiscovery

final class MovieListViewModelTests: XCTestCase {

    var viewModel: MovieListViewModel!
    var mockService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        viewModel = MovieListViewModel(apiService: mockService)
    }

    func testLoadPopularMoviesLoadsFromJSON() {
            let expectation = self.expectation(description: "Movies loaded")

            viewModel.onMoviesUpdated = {
                XCTAssertGreaterThan(self.viewModel.count, 0, "Should load movies from JSON")
                expectation.fulfill()
            }

            viewModel.loadPopularMovies()
            wait(for: [expectation], timeout: 1.0)
        }

    func testSearchMoviesFiltersCorrectly() {
            let expectation = self.expectation(description: "Search filtered")

            viewModel.onMoviesUpdated = {
                let titles = self.viewModel.movies.map({ movie in
                    return movie.title
                })
                XCTAssertTrue(titles.allSatisfy { $0.contains("Novocaine") }, "Filtered results should contain query")
                expectation.fulfill()
            }

            viewModel.searchMovies(query: "Novocaine")
            wait(for: [expectation], timeout: 1.0)
        }
}
