//
//  ListMoviesPresentationLogicSpy.swift
//  MovieDatabase
//
//  Created on 31-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

@testable import MovieDatabase

class ListMoviesPresentationLogicSpy: ListMoviesPresentationLogic {

    var presentMoviesGotCalled = false
    var presentMoviesResponse: ListMovies.FetchMovies.Response?
    func presentMovies(response: ListMovies.FetchMovies.Response) {
        presentMoviesGotCalled = true
        presentMoviesResponse = response
    }

    var presentLocalizeGotCalled = false
    var presentLocalizeResponse: ListMovies.LocalizeText.Response?
    func presentLocalize(response: ListMovies.LocalizeText.Response) {
        presentLocalizeGotCalled = true
        presentLocalizeResponse = response
    }

//     var presentSomethingCalled = false
//     var presentSomethingResponse: ListMovies.Something.Response?
//     func presentSomething(response: ListMovies.Something.Response) {
//        presentSomethingCalled = true
//        presentSomethingResponse = response
//    }
}
