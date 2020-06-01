//
//  MovieDetailsInteractorTests.swift
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

@testable import MovieDatabase
import XCTest

class MovieDetailsInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: MovieDetailsInteractor!
    var spyPresenter: MovieDetailsPresentationLogicSpy!
    var spyWorker: MovieDetailsWorkerSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupMovieDetailsInteractor()
    }

    override  func tearDown() {
        spyPresenter = nil
        spyWorker = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieDetailsInteractor() {
        sut = MovieDetailsInteractor()

        spyPresenter = MovieDetailsPresentationLogicSpy()
        sut.presenter = spyPresenter

        spyWorker = MovieDetailsWorkerSpy()
        sut.worker = spyWorker
    }

    // MARK: Test doubles

    class MovieDetailsWorkerSpy: MovieDetailsWorker {

    }

    // MARK: Tests
    func testProcessMovieDetailsCallsPresenter() {
        // Given
        let movie3 = Movie(popularity: nil, voteCount: nil, video: nil, posterPath: nil, id: nil, adult: nil, backdropPath: nil, originalLanguage: nil, originalTitle: nil, genreIDS: nil, title: "movie3", voteAverage: nil, overview: "overview", releaseDate: "2000-12-01")
        sut.movie = movie3
        // When
        sut.processMovie()
        // Then
        XCTAssertTrue(spyPresenter.presentMovieDetailsGotCalled)
        XCTAssertEqual(spyPresenter.presentMovieDetailsResponse?.title, movie3.title)
        XCTAssertEqual(spyPresenter.presentMovieDetailsResponse?.overview, movie3.overview)
        XCTAssertEqual(spyPresenter.presentMovieDetailsResponse?.releaseDate, movie3.releaseDate)
    }

    func testProcessMovieEmptyDetailsCallsPresenter() {
        // Given
        let movie3 = Movie(popularity: nil, voteCount: nil, video: nil, posterPath: nil, id: nil, adult: nil, backdropPath: nil, originalLanguage: nil, originalTitle: nil, genreIDS: nil, title: nil, voteAverage: nil, overview: nil, releaseDate: nil)
        sut.movie = movie3
        // When
        sut.processMovie()
        // Then
        XCTAssertTrue(spyPresenter.presentMovieDetailsGotCalled)
        XCTAssertEqual(spyPresenter.presentMovieDetailsResponse?.title, "--")
        XCTAssertEqual(spyPresenter.presentMovieDetailsResponse?.overview, "")
        XCTAssertEqual(spyPresenter.presentMovieDetailsResponse?.releaseDate, "")
    }

}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
