//
//  ListMoviesModels.swift
//  MovieDatabase
//
//  Created on 30-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import UIKit

enum ListMovies {
    // MARK: Use cases

    enum FetchMovies {
        struct Request {
            let movies: [Movie]
        }
        struct Response {
            let movies: [Movie]
        }
        struct ViewModel {
            let movies: [String]
        }
    }
    enum PrefetchMovies {
        struct Request {
            let row: Int
        }
    }

    enum LocalizeText {
        struct Response {
            let title: Localizable
        }
        struct ViewModel {
            let title: String
        }
    }
}
