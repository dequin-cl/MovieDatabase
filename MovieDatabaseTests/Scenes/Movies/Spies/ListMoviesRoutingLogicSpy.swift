//
//  ListMoviesRoutingLogicSpy.swift
//  MovieDatabase
//
//  Created on 31-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

@testable import MovieDatabase
import XCTest

class ListMoviesRoutingLogicSpy: NSObject, ListMoviesRoutingLogic, ListMoviesDataPassing {
    var routeToMovieDetailsGotCalled = false
    var routeToMovieDetailsSegue: UIStoryboardSegue?
    func routeToMovieDetails(segue: UIStoryboardSegue?) {
        routeToMovieDetailsGotCalled = true
        routeToMovieDetailsSegue = segue
    }

    var dataStore: ListMoviesDataStore?
}

class ListMoviesRouterMock: ListMoviesRouter {
    var navigateToMovieDetailsGotCalled = false
    var navigateToMovieDetailsSource: ListMoviesViewController?
    var navigateToMovieDetailsDestination: MovieDetailsViewController?
    override func navigateToMovieDetails(source: ListMoviesViewController, destination: MovieDetailsViewController) {
        navigateToMovieDetailsGotCalled = true
        navigateToMovieDetailsSource = source
        navigateToMovieDetailsDestination = destination
    }

    var passDataToMovieDetailsGotCalled = false
    var passDataToMovieDetailsSource: ListMoviesDataStore?
    var passDataToMovieDetailsDestination: MovieDetailsDataStore?
    override func passDataToMovieDetails(source: ListMoviesDataStore, destination: inout MovieDetailsDataStore) {
        passDataToMovieDetailsGotCalled = true
        passDataToMovieDetailsSource = source
        passDataToMovieDetailsDestination  = destination
    }
}

class ListMoviesViewControllerMock: ListMoviesViewController {
    var showGotCalled = false
    var showVC: UIViewController?
    var showSender: Any?
    override func show(_ vc: UIViewController, sender: Any?) {
        showGotCalled = true
        showVC = vc
        showSender = sender
    }

}
