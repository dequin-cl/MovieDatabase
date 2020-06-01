//
//  ListMoviesPresenter.swift
//  MovieDatabase
//
//  Created on 30-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import UIKit

protocol ListMoviesPresentationLogic {
    func presentMovies(response: ListMovies.FetchMovies.Response)
    func presentLocalize(response: ListMovies.LocalizeText.Response)
    func presentMovieDetails()
}

class ListMoviesPresenter: ListMoviesPresentationLogic {
    weak var viewController: ListMoviesDisplayLogic?

    // MARK: Do something

    func presentMovies(response: ListMovies.FetchMovies.Response) {
        let movieTitles = response.movies.map( {$0.title != nil ? $0.title!: "--"})
        let viewModel = ListMovies.FetchMovies.ViewModel(movies: movieTitles)

        viewController?.displayMovies(viewModel: viewModel)
    }

    func presentLocalize(response: ListMovies.LocalizeText.Response) {
        let viewModel = ListMovies.LocalizeText.ViewModel(title: response.title.localized)
        viewController?.displayLocalized(viewModel: viewModel)
    }

    func presentMovieDetails() {
        viewController?.routeToMovieDetails()
    }
}
