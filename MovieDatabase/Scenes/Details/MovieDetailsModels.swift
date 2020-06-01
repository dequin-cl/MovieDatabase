//
//  MovieDetailsModels.swift
//  MovieDatabase
//
//  Created on 01-06-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

// swiftlint:disable nesting
enum MovieDetails {

    enum Display {
        struct Request {
        }
        struct Response {
            let title: String
            let overview: String
            let releaseDate: String
        }
        struct ViewModel {
            let title: String
            let overview: String
            let releaseDate: String
        }
    }

    enum DisplayPoster {
        struct Response {
            let path: String
        }
        struct ViewModel {
            let path: String
        }
    }
}

// swiftlint:enable nesting
