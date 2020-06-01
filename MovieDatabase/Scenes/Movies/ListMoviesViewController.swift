//
//  ListMoviesViewController.swift
//  MovieDatabase
//
//  Created on 30-05-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import UIKit

protocol ListMoviesDisplayLogic: class {
    func displayMovies(viewModel: ListMovies.FetchMovies.ViewModel)
    func displayLocalized(viewModel: ListMovies.LocalizeText.ViewModel)
    func routeToMovieDetails()
}

class ListMoviesViewController: UITableViewController, ListMoviesDisplayLogic {
    var interactor: ListMoviesBusinessLogic?
    var router: (NSObjectProtocol & ListMoviesRoutingLogic & ListMoviesDataPassing)?

    var moviesTitles: [String]!
    private let CellIdentifier = "MovieCell"
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ListMoviesInteractor()
        let presenter = ListMoviesPresenter()
        let router = ListMoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        doInitialFetch()
    }

    // MARK: Do something
    func localize() {
        interactor?.localize()
    }

    func displayLocalized(viewModel: ListMovies.LocalizeText.ViewModel) {
        title = viewModel.title
    }

    func doInitialFetch() {
        interactor?.fetchMovies()
    }

    func displayMovies(viewModel: ListMovies.FetchMovies.ViewModel) {
        moviesTitles = viewModel.movies

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func routeToMovieDetails() {
        router?.routeToMovieDetails(segue: nil)
    }

    // MARK:-  UITableView Delegate
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        interactor?.processWillDisplay(request: ListMovies.PrefetchMovies.Request(row: indexPath.row))
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.processSelection(request: ListMovies.Selection.Request(row: indexPath.row))
    }

    // MARK:-  UITableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let moviesTitles = moviesTitles else { return 0 }

        return moviesTitles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.textLabel?.text = moviesTitles[indexPath.row]
        return cell
    }
}
