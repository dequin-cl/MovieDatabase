//
//  MovieDetailsPresentationLogicSpy.swift
//  MovieDatabase
//
//  Created on 01-06-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

@testable import MovieDatabase

class MovieDetailsPresentationLogicSpy: MovieDetailsPresentationLogic {

    var presentMovieDetailsGotCalled = false
    var presentMovieDetailsResponse: MovieDetails.Display.Response?
    func presentMovieDetails(response: MovieDetails.Display.Response) {
        presentMovieDetailsGotCalled = true
        presentMovieDetailsResponse = response
    }

    var presentMoviePosterGotCalled = false
    var presentMoviePosterResponse: MovieDetails.DisplayPoster.Response?
    func presentMoviePoster(response: MovieDetails.DisplayPoster.Response) {
        presentMoviePosterGotCalled = true
        presentMoviePosterResponse = response
    }
}
