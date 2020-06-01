//
//  ListMoviesViewControllerTests.swift
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

class ListMoviesViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: ListMoviesViewController!
    var spyInteractor: ListMoviesBusinessLogicSpy!
    var spyRouter: ListMoviesRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupListMoviesViewController()
    }

    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupListMoviesViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "ListMoviesViewController") as! ListMoviesViewController)

        spyInteractor = ListMoviesBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = ListMoviesRoutingLogicSpy()
        sut.router = spyRouter

        loadView()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    func testLoad() {
        // Given
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertTrue(spyInteractor.localizeGotCalled)
        XCTAssertTrue(spyInteractor.fetchMoviesGotCalled)

    }

    // MARK: Tests
    func testLocalize() {
        // Given
        // When
        sut.localize()
        // Then
        XCTAssertTrue(spyInteractor.localizeGotCalled)
    }

    func testDisplayLocalized() {
        // Given
        let viewModel = ListMovies.LocalizeText.ViewModel(title: "LALA")
        // When
        sut.displayLocalized(viewModel: viewModel)
        // Then
        XCTAssertEqual(sut.title, "LALA")
    }

    func testInitialFetch() {
        // Given
        // When
        sut.doInitialFetch()
        // Then
        XCTAssertTrue(spyInteractor.fetchMoviesGotCalled)
    }

    func testDisplayMovies() {
        // Given
        let viewModel = ListMovies.FetchMovies.ViewModel(movies: ["A", "B", "C"])
        // When
        sut.displayMovies(viewModel: viewModel)
        // Then
        XCTAssertEqual(sut.moviesTitles.count, 3)
    }
}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
