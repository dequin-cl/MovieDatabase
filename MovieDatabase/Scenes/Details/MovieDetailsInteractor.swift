//
//  MovieDetailsInteractor.swift
//  MovieDatabase
//
//  Created on 01-06-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import Foundation

protocol MovieDetailsBusinessLogic {
    func processMovie()
}

protocol MovieDetailsDataStore {
    //var name: String { get set }
    var movie: Movie? { get set }
}

class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    var presenter: MovieDetailsPresentationLogic?
    var worker: MovieDetailsWorker = MovieDetailsWorker()

    var movie: Movie?

    // MARK: Methods

    func processMovie() {
        guard let movie = movie else { fatalError("This scene should not be called without a Movie") }

        let response = MovieDetails.Display.Response(
            title: movie.title ?? "--",
            overview: movie.overview ?? "",
            releaseDate: movie.releaseDate ?? ""
        )
        presenter?.presentMovieDetails(response: response)
    }
}
