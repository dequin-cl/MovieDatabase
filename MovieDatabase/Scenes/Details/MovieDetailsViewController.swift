//
//  MovieDetailsViewController.swift
//  MovieDatabase
//
//  Created on 01-06-20.
//  Copyright © 2020 @dequin_cl All rights reserved.
//

import UIKit

protocol MovieDetailsDisplayLogic: AnyObject {
    func displayMovieDetails(viewModel: MovieDetails.Display.ViewModel)
}

class MovieDetailsViewController: UIViewController, MovieDetailsDisplayLogic {
    var interactor: MovieDetailsBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailsRoutingLogic & MovieDetailsDataPassing)?

    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieOverview: UILabel!
    @IBOutlet weak var labelMovieReleaseDate: UILabel!

    // MARK: Object lifecycle

    override  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
        let interactor = MovieDetailsInteractor()
        let presenter = MovieDetailsPresenter()
        let router = MovieDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override  func viewDidLoad() {
        super.viewDidLoad()
        processSelectedMovie()
    }

    // MARK: Methods

     func processSelectedMovie() {

        interactor?.processMovie()
    }

    func displayMovieDetails(viewModel: MovieDetails.Display.ViewModel) {
        labelMovieTitle.text = viewModel.title
        labelMovieOverview.text = viewModel.overview
        labelMovieReleaseDate.text = viewModel.releaseDate
    }
}
