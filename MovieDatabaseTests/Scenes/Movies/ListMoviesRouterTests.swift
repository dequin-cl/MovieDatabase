//
//  ListMoviesRouterTests.swift
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

class ListMoviesRouterTests: XCTestCase {
    // MARK: Subject under test

    var sut: ListMoviesRouter!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupListMoviesRouter()
    }

    override  func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupListMoviesRouter() {
        sut = ListMoviesRouter()
    }

    // MARK: Tests
    func testRouteToDetailsCallPassDataAndNavigateWhenSegueIsNil() {
        // Given
        let segue: UIStoryboardSegue? = nil
        let specialSUT = ListMoviesRouterMock()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ListMoviesViewController") as! ListMoviesViewController
        specialSUT.viewController = vc

        let dataStore = ListMoviesInteractor()
        specialSUT.dataStore = dataStore
        // When
        specialSUT.routeToMovieDetails(segue: segue)
        // Then
        XCTAssertTrue(specialSUT.navigateToMovieDetailsGotCalled)
        XCTAssertEqual(specialSUT.navigateToMovieDetailsSource, vc)

        XCTAssertTrue(specialSUT.passDataToMovieDetailsGotCalled)
        XCTAssertTrue(specialSUT.passDataToMovieDetailsSource as AnyObject? === dataStore)
    }

    func testNavigationToDetails() {
        // Given
        let listMoviesVCMock = ListMoviesViewControllerMock(nibName: nil, bundle: nil)
        let movieDetailsVC = MovieDetailsViewController()
        // When
        sut.navigateToMovieDetails(source: listMoviesVCMock, destination: movieDetailsVC)
        // Then
        XCTAssertTrue(listMoviesVCMock.showGotCalled)
        XCTAssertTrue(listMoviesVCMock.showSender as AnyObject? === listMoviesVCMock)
        XCTAssertEqual(listMoviesVCMock.showVC, movieDetailsVC)
    }

    func testPassDataToDetails() {
        // Given
        let movie1 = Movie(popularity: nil, voteCount: nil, video: nil, posterPath: nil, id: nil, adult: nil, backdropPath: nil, originalLanguage: nil, originalTitle: nil, genreIDS: nil, title: nil, voteAverage: nil, overview: nil, releaseDate: nil)
        let destinationVC = MovieDetailsViewController()
        var destinationDS = destinationVC.router!.dataStore!
        let listMoviesInteractor = ListMoviesInteractor()
        listMoviesInteractor.selectedMovie = movie1
        let dataSource = listMoviesInteractor
        // When
        sut.passDataToMovieDetails(source: dataSource, destination: &destinationDS)
        // Then
        XCTAssertNotNil(destinationDS.movie)
        XCTAssertEqual(listMoviesInteractor.selectedMovie, destinationDS.movie)
    }
}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
