//
//  MovieDetailsInteractor.swift
//  MovieDatabase
//
//  Created on 01-06-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import Foundation

protocol MovieDetailsBusinessLogic {
//    func doSomething(request: MovieDetails.Something.Request)
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

//     func doSomething(request: MovieDetails.Something.Request) {
//        worker.doSomeWork()
//
//        let response = MovieDetails.Something.Response()
//        presenter?.presentSomething(response: response)
//    }
}
