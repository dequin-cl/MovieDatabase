//
//  ListMoviesDisplayLogicSpy.swift
//  MovieDatabase
//
//  Created on 31-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

@testable import MovieDatabase

class ListMoviesDisplayLogicSpy: ListMoviesDisplayLogic {
    var displayMoviesGotCalled = false
    var displayMoviesViewModel: ListMovies.FetchMovies.ViewModel?
    func displayMovies(viewModel: ListMovies.FetchMovies.ViewModel) {
        displayMoviesGotCalled = true
        displayMoviesViewModel = viewModel
    }

    var displayLocalizedGotCalled = false
    var displayLocalizedViewModel: ListMovies.LocalizeText.ViewModel?
    func displayLocalized(viewModel: ListMovies.LocalizeText.ViewModel) {
        displayLocalizedGotCalled = true
        displayLocalizedViewModel = viewModel
    }

    var routeToMovieDetailsGotCalled = false
    func routeToMovieDetails() {
        routeToMovieDetailsGotCalled = true
    }
}
