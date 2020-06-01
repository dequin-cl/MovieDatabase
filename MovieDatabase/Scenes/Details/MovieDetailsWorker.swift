//
//  MovieDetailsWorker.swift
//  MovieDatabase
//
//  Created on 01-06-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import Foundation

class MovieDetailsWorker {

    private let configurationURL = "https://api.themoviedb.org/3/configuration"
    private let apikey = "api_key="

    func fetchConfiguration(session: URLSession = URLSession(configuration: .default),
                            apiKeys: APIKeys = APIKeysLoader.loadKeys(),
                            completionHandler: @escaping (Configuration) -> Void) {
        if let url = buildURL(apiKeys: apiKeys) {

            let task = session.dataTask(with: url) { (data, _, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Configuration.self, from: safeData)
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

    private func buildURL(apiKeys: APIKeys) -> URL? {
        let url = "\(configurationURL)?\(apikey)\(apiKeys.authV3)"

        return URL(string: url)
    }

    func fetchPosterImageURL(posterPath: String,
                             session: URLSession = URLSession(configuration: .default),
                             apiKeys: APIKeys = APIKeysLoader.loadKeys(),
                             completionHandler: @escaping (String) -> Void) {
        
        fetchConfiguration(session: session, apiKeys: apiKeys) { (configuration) in
            let urlParts = [configuration.images.baseURL,
                            configuration.images.posterSizes.last!,
                            posterPath]

            completionHandler(urlParts.joined())
        }
    }
}
