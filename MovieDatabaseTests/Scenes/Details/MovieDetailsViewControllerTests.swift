//
//  MovieDetailsViewControllerTests.swift
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

class MovieDetailsViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: MovieDetailsViewController!
    var spyInteractor: MovieDetailsBusinessLogicSpy!
    var spyRouter: MovieDetailsRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupMovieDetailsViewController()
    }

    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieDetailsViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController)

        spyInteractor = MovieDetailsBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = MovieDetailsRoutingLogicSpy()
        sut.router = spyRouter

        loadView()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests
    func testShouldCallProcessMovie() {
        // Given
        // When
        // Then
        XCTAssertTrue(spyInteractor.processMovieGotCalled)
    }

    func testDisplayMovieDetails() {
        // Given
        let title = "Test"
        let overview = "Test2"
        let releaseDate = "Test3"
        let viewModel = MovieDetails.Display.ViewModel(title: title, overview: overview, releaseDate: releaseDate)
        // When
        sut.displayMovieDetails(viewModel: viewModel)
        // Then
        XCTAssertEqual(sut.labelMovieTitle.text, title)
        XCTAssertEqual(sut.labelMovieOverview.text, overview)
        XCTAssertEqual(sut.labelMovieReleaseDate.text, releaseDate)
    }

    func testDisplayPoster() {
        // Given
        let path = "http://tmdb.org"
        let viewModel = MovieDetails.DisplayPoster.ViewModel(path: path)
        let exp = expectation(description: "Loading stories")

        // When
        sut.displayPoster(viewModel: viewModel) {
            exp.fulfill()
        }
        // Then
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(sut.imagePosterContainer.kf.indicator)
    }
}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
