//
//  ListMoviesInteractorTests.swift
//  MovieDatabase
//
//  Created on 31-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable force_cast
// swiftlint:disable identifier_name
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable line_length

@testable import MovieDatabase
import XCTest

class ListMoviesInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: ListMoviesInteractor!
    var spyPresenter: ListMoviesPresentationLogicSpy!
    var spyWorker: ListMoviesWorkerSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupListMoviesInteractor()
    }

    override  func tearDown() {
        spyPresenter = nil
        spyWorker = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupListMoviesInteractor() {
        sut = ListMoviesInteractor()

        spyPresenter = ListMoviesPresentationLogicSpy()
        sut.presenter = spyPresenter

        spyWorker = ListMoviesWorkerSpy()
        sut.worker = spyWorker
    }

    // MARK: Test doubles

    class ListMoviesWorkerSpy: ListMoviesWorker {
        private let sampleJson = """
{
    "page": 1,
    "total_results": 10000,
    "total_pages": 500,
    "results": [
        {
            "popularity": 581.092,
            "vote_count": 3547,
            "video": false,
            "poster_path": "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
            "id": 419704,
            "adult": false,
            "backdrop_path": "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg",
            "original_language": "en",
            "original_title": "Ad Astra",
            "genre_ids": [
                18,
                878
            ],
            "title": "Ad Astra",
            "vote_average": 6,
            "overview": "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.",
            "release_date": "2019-09-17"
        }
    ]
}
"""
        var fetchPopularMoviesGotCalled = false
        override func fetchPopularMovies(pageNumber: Int, session: URLSession = URLSession(configuration: .default), apiKeys: APIKeys = APIKeysLoader.loadKeys(), completionHandler: @escaping (Popularity) -> Void) {
            fetchPopularMoviesGotCalled = true

            let data = Data(sampleJson.utf8)
            let results = try! JSONDecoder().decode(Popularity.self, from: data)
            completionHandler(results)
        }
    }

    // MARK: Tests
    func testFetchMovies() {
        // Given
        sut.lastPageFetched = 1
        // When
        sut.fetchMovies()
        // Then
        XCTAssertEqual(sut.lastPageFetched, 2)
        XCTAssertTrue(spyPresenter.presentMoviesGotCalled)
        XCTAssertEqual(spyPresenter.presentMoviesResponse?.movies.count, 1)
    }
}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
