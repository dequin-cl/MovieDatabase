//
//  MovieDetailsRoutingLogicSpy.swift
//  MovieDatabase
//
//  Created on 01-06-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

@testable import MovieDatabase
import Foundation

class MovieDetailsRoutingLogicSpy: NSObject, MovieDetailsRoutingLogic, MovieDetailsDataPassing {
    var dataStore: MovieDetailsDataStore?
}
