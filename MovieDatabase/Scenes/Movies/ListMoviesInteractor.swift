//
//  ListMoviesInteractor.swift
//  MovieDatabase
//
//  Created on 30-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import UIKit

protocol ListMoviesBusinessLogic {
    func fetchMovies()
    func processWillDisplay(request: ListMovies.PrefetchMovies.Request)
    func localize()
}

protocol ListMoviesDataStore {
    //var name: String { get set }
}

class ListMoviesInteractor: ListMoviesBusinessLogic, ListMoviesDataStore {
    var presenter: ListMoviesPresentationLogic?
    var worker: ListMoviesWorker = ListMoviesWorker()

    var lastPageFetched: Int = 1
    var popularity: Popularity?
    var movies: [Movie] = []

    // MARK: Fetch Movies
    func fetchMovies() {
        worker.fetchPopularMovies(pageNumber: lastPageFetched) { (popularity) in
            self.popularity = popularity
            self.movies.append(contentsOf: popularity.movies)

            let response = ListMovies.FetchMovies.Response(movies: self.movies)
            self.lastPageFetched += 1
            self.presenter?.presentMovies(response: response)
        }
    }

    func processWillDisplay(request: ListMovies.PrefetchMovies.Request) {

        if request.row + 10 > movies.count {
            fetchMovies()
        }
    }

    func localize() {
        let response = ListMovies.LocalizeText.Response(title: ListMoviesStrings.Movies)
        presenter?.presentLocalize(response: response)
    }
}
