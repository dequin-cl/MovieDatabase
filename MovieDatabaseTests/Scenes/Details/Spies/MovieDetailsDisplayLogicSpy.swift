//
//  MovieDetailsDisplayLogicSpy.swift
//  MovieDatabase
//
//  Created on 01-06-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

@testable import MovieDatabase

class MovieDetailsDisplayLogicSpy: MovieDetailsDisplayLogic {
    var displayMovieDetailsGotCalled = false
    var displayMovieDetailsViewModel: MovieDetails.Display.ViewModel?
    func displayMovieDetails(viewModel: MovieDetails.Display.ViewModel) {
        displayMovieDetailsGotCalled = true
        displayMovieDetailsViewModel = viewModel
    }


}
