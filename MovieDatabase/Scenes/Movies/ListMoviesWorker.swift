//
//  ListMoviesWorker.swift
//  MovieDatabase
//
//  Created on 30-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import UIKit

enum ListMoviesStrings: String, CaseIterable, Localizable {
    var tableName: String {
        return "ListMovies"
    }

    case Movies
}

class ListMoviesWorker {
    let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular"
    let apikey = "api_key="
    let language = "language="
    let page = "page="
    var lastPageRequested = 0

    func fetchPopularMovies(pageNumber: Int,
                            session: URLSession = URLSession(configuration: .default),
                            apiKeys: APIKeys = APIKeysLoader.loadKeys(),
                            completionHandler: @escaping (Popularity) -> Void) {

        guard pageNumber != lastPageRequested else {
            return
        }
        lastPageRequested = pageNumber
        
        if let url = buildURL(pageNumber: pageNumber, apiKeys: apiKeys) {

            let task = session.dataTask(with: url) { (data, _, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Popularity.self, from: safeData)
                            completionHandler(results)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }

    private func buildURL(pageNumber: Int,
                          apiKeys: APIKeys) -> URL? {
        var url = "\(popularMoviesURL)?\(apikey)\(apiKeys.authV3)"
        url += "&" + language + Locale.preferredLocale().identifier
        url += "&" + page + String(pageNumber)

        return URL(string: url)
    }
}

extension Locale {
    static func preferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}
