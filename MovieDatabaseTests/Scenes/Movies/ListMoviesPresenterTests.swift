//
//  ListMoviesPresenterTests.swift
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

class ListMoviesPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: ListMoviesPresenter!
    var spyViewController: ListMoviesDisplayLogicSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupListMoviesPresenter()
    }

    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupListMoviesPresenter() {
        sut = ListMoviesPresenter()

        spyViewController = ListMoviesDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests

    func testPresentMovies() {
        // Given
        let movie1 = Movie(popularity: nil, voteCount: nil, video: nil, posterPath: nil, id: nil, adult: nil, backdropPath: nil, originalLanguage: nil, originalTitle: nil, genreIDS: nil, title: nil, voteAverage: nil, overview: nil, releaseDate: nil)
        let movie2 = Movie(popularity: nil, voteCount: nil, video: nil, posterPath: nil, id: nil, adult: nil, backdropPath: nil, originalLanguage: nil, originalTitle: nil, genreIDS: nil, title: "movie2", voteAverage: nil, overview: nil, releaseDate: nil)
        let movie3 = Movie(popularity: nil, voteCount: nil, video: nil, posterPath: nil, id: nil, adult: nil, backdropPath: nil, originalLanguage: nil, originalTitle: nil, genreIDS: nil, title: "movie3", voteAverage: nil, overview: nil, releaseDate: nil)

        let response = ListMovies.FetchMovies.Response(movies: [movie1, movie2, movie3])
        // When
        sut.presentMovies(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayMoviesGotCalled)
        XCTAssertEqual(spyViewController.displayMoviesViewModel?.movies.count, 3)
        XCTAssertEqual(spyViewController.displayMoviesViewModel?.movies.first, "--")
    }

    func testPresentLocalize() {
        // Given
        let response = ListMovies.LocalizeText.Response(title: ListMoviesStrings.Movies)
        // When
        sut.presentLocalize(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayLocalizedGotCalled)
        XCTAssertEqual(spyViewController.displayLocalizedViewModel?.title, ListMoviesStrings.Movies.localized)
    }

    func testPresentMoviesDetails() {
        // Given

        // When
        sut.presentMovieDetails()
        // Then
        XCTAssertTrue(spyViewController.routeToMovieDetailsGotCalled)
    }
}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
