//
//  ListMoviesRouter.swift
//  MovieDatabase
//
//  Created on 30-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import UIKit

@objc protocol ListMoviesRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ListMoviesDataPassing {
    var dataStore: ListMoviesDataStore? { get }
}

class ListMoviesRouter: NSObject, ListMoviesRoutingLogic, ListMoviesDataPassing {
    weak var viewController: ListMoviesViewController?
    var dataStore: ListMoviesDataStore?

    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: ListMoviesViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: ListMoviesDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
