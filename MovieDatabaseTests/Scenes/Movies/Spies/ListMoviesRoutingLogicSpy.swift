//
//  ListMoviesRoutingLogicSpy.swift
//  MovieDatabase
//
//  Created on 31-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

@testable import MovieDatabase
import Foundation

class ListMoviesRoutingLogicSpy: NSObject, ListMoviesRoutingLogic, ListMoviesDataPassing {
    var dataStore: ListMoviesDataStore?
}
