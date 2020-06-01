//
//  ListMoviesRouter.swift
//  MovieDatabase
//
//  Created on 30-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import UIKit

@objc protocol ListMoviesRoutingLogic {
    func routeToMovieDetails(segue: UIStoryboardSegue?)
}

protocol ListMoviesDataPassing {
    var dataStore: ListMoviesDataStore? { get }
}

class ListMoviesRouter: NSObject, ListMoviesRoutingLogic, ListMoviesDataPassing {
    weak var viewController: ListMoviesViewController?
    var dataStore: ListMoviesDataStore?

    // MARK: Routing

    func routeToMovieDetails(segue: UIStoryboardSegue?) {
      if let segue = segue {
        let destinationVC = segue.destination as! MovieDetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMovieDetails(source: dataStore!, destination: &destinationDS)
      } else {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMovieDetails(source: dataStore!, destination: &destinationDS)
        navigateToMovieDetails(source: viewController!, destination: destinationVC)
      }
    }

    // MARK: Navigation

    func navigateToMovieDetails(source: ListMoviesViewController, destination: MovieDetailsViewController) {
      source.show(destination, sender: source)
    }

    // MARK: Passing data

    func passDataToMovieDetails(source: ListMoviesDataStore, destination: inout MovieDetailsDataStore) {
      destination.movie = source.selectedMovie
    }
}
