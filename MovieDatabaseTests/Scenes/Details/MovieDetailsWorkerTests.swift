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

}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
