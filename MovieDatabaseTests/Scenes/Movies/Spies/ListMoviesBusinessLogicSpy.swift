//
//  ListMoviesBusinessLogicSpy.swift
//  MovieDatabase
//
//  Created on 31-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

@testable import MovieDatabase

class ListMoviesBusinessLogicSpy: ListMoviesBusinessLogic {
    var fetchMoviesGotCalled = false
    func fetchMovies() {
        fetchMoviesGotCalled = true
    }

    var processWillDisplayGotCalled = false
    var processWillDisplayRequest: ListMovies.PrefetchMovies.Request?
    func processWillDisplay(request: ListMovies.PrefetchMovies.Request) {
        processWillDisplayGotCalled = true
        processWillDisplayRequest = request
    }

    var localizeGotCalled = false
    func localize() {
        localizeGotCalled = true
    }
}
