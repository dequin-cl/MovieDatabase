//
//  ListMoviesWorkerTests.swift
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

//import OHHTTPStubs
@testable import MovieDatabase
import XCTest

class ListMoviesWorkerTests: XCTestCase {
    // MARK: Subject under test

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

    var sut: ListMoviesWorker!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupListMoviesWorker()
    }

    override  func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupListMoviesWorker() {
        sut = ListMoviesWorker()
    }

    // MARK: Tests

    func testFetchPopularMoviesSuccess() {
        // Given
        let data = Data(sampleJson.utf8)
        let aURLSessionMock = URLSessionMock()
        let apiKeys = APIKeys(authV4: "foo", authV3: "bar")
        aURLSessionMock.data = data
        aURLSessionMock.error = nil
        // When
        sut.fetchPopularMovies(pageNumber: 1, session: aURLSessionMock, apiKeys: apiKeys) { (popularity) in
            // Then
            XCTAssertEqual(popularity.movies.count, 1)
            XCTAssertEqual(popularity.movies.first!.title, "Ad Astra")
        }
        XCTAssertEqual(aURLSessionMock.url!.absoluteString, "https://api.themoviedb.org/3/movie/popular?api_key=bar&language=en&page=1")
    }
}

class URLSessionMock: URLSession {
    var data: Data?
    var error: Error?
    var url: URL?

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        self.url = url
        return URLSessionDataTaskMock {
            completionHandler(self.data, nil, self.error)
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}
// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
