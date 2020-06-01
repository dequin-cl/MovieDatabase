//
//  MovieDetailsPresenter.swift
//  MovieDatabase
//
//  Created on 01-06-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import UIKit

protocol MovieDetailsPresentationLogic {
    func presentMovieDetails(response: MovieDetails.Display.Response)
    func presentMoviePoster(response: MovieDetails.DisplayPoster.Response)
}

class MovieDetailsPresenter: MovieDetailsPresentationLogic {
    weak  var viewController: MovieDetailsDisplayLogic?

    private lazy var intoDateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [
            .withYear,
            .withDashSeparatorInDate,
            .withMonth,
            .withDay
        ]
        return dateFormatter
    }()

    private lazy var intoStringFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }()
    // MARK: Methods

    func presentMovieDetails(response: MovieDetails.Display.Response) {

        let date = intoDateFormatter.date(from: response.releaseDate)
        let releaseDateString = date != nil ? intoStringFormatter.string(from: date!): ""
        let viewModel = MovieDetails.Display.ViewModel(
            title: response.title,
            overview: response.overview,
            releaseDate: releaseDateString)
        viewController?.displayMovieDetails(viewModel: viewModel)
    }

    func presentMoviePoster(response: MovieDetails.DisplayPoster.Response) {
        let viewModel = MovieDetails.DisplayPoster.ViewModel(path: response.path)
        viewController?.displayPoster(viewModel: viewModel, completion: nil)
    }
}
