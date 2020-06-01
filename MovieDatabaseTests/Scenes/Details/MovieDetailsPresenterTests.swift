//
//  MovieDetailsPresenterTests.swift
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

class MovieDetailsPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: MovieDetailsPresenter!
    var spyViewController: MovieDetailsDisplayLogicSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupMovieDetailsPresenter()
    }

    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieDetailsPresenter() {
        sut = MovieDetailsPresenter()

        spyViewController = MovieDetailsDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests

}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
