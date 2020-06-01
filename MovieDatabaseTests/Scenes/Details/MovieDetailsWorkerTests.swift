//
//  MovieDetailsWorkerTests.swift
//  MovieDatabase
//
//  Created on 01-06-20.
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

class MovieDetailsWorkerTests: XCTestCase {
    // MARK: Subject under test

    private let configurationSample = """
{
  "images": {
    "base_url": "http://image.tmdb.org/t/p/",
    "secure_base_url": "https://image.tmdb.org/t/p/",
    "backdrop_sizes": [
      "w300",
      "w780",
      "w1280",
      "original"
    ],
    "logo_sizes": [
      "w45",
      "w92",
      "w154",
      "w185",
      "w300",
      "w500",
      "original"
    ],
    "poster_sizes": [
      "w92",
      "w154",
      "w185",
      "w342",
      "w500",
      "w780",
      "original"
    ],
    "profile_sizes": [
      "w45",
      "w185",
      "h632",
      "original"
    ],
    "still_sizes": [
      "w92",
      "w185",
      "w300",
      "original"
    ]
  },
  "change_keys": [
    "adult",
    "air_date",
    "also_known_as",
    "alternative_titles",
    "biography",
    "birthday",
    "budget",
    "cast",
    "certifications",
    "character_names",
    "created_by",
    "crew",
    "deathday",
    "episode",
    "episode_number",
    "episode_run_time",
    "freebase_id",
    "freebase_mid",
    "general",
    "genres",
    "guest_stars",
    "homepage",
    "images",
    "imdb_id",
    "languages",
    "name",
    "network",
    "origin_country",
    "original_name",
    "original_title",
    "overview",
    "parts",
    "place_of_birth",
    "plot_keywords",
    "production_code",
    "production_companies",
    "production_countries",
    "releases",
    "revenue",
    "runtime",
    "season",
    "season_number",
    "season_regular",
    "spoken_languages",
    "status",
    "tagline",
    "title",
    "translations",
    "tvdb_id",
    "tvrage_id",
    "type",
    "video",
    "videos"
  ]
}
"""

    var sut: MovieDetailsWorker!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupMovieDetailsWorker()
    }

    override  func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieDetailsWorker() {
        sut = MovieDetailsWorker()
    }

    // MARK: Tests
    func testFetchConfiguration() {
        // Given
        let data = Data(configurationSample.utf8)
        let aURLSessionMock = URLSessionMock()
        let apiKeys = APIKeys(authV4: "foo", authV3: "bar")
        aURLSessionMock.data = data
        aURLSessionMock.error = nil

        // When
        sut.fetchConfiguration(session: aURLSessionMock, apiKeys: apiKeys) { (configuration) in
            // Then
            XCTAssertEqual(configuration.images.baseURL, "http://image.tmdb.org/t/p/")
            XCTAssertEqual(configuration.images.posterSizes.last, "original")
        }

        // Then
        XCTAssertEqual(aURLSessionMock.url!.absoluteString, "https://api.themoviedb.org/3/configuration?api_key=bar")
    }

    func testFetchPosterImageURL() {
        // Given
        let posterPath = "/sample"
        let data = Data(configurationSample.utf8)
        let aURLSessionMock = URLSessionMock()
        let apiKeys = APIKeys(authV4: "foo", authV3: "bar")
        aURLSessionMock.data = data
        aURLSessionMock.error = nil

        // When
        sut.fetchPosterImageURL(posterPath: posterPath, session: aURLSessionMock, apiKeys: apiKeys) { (path) in
            // Then
            XCTAssertEqual(path, "http://image.tmdb.org/t/p/original/sample")
        }

        // Then
        XCTAssertEqual(aURLSessionMock.url!.absoluteString, "https://api.themoviedb.org/3/configuration?api_key=bar")
    }

}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
