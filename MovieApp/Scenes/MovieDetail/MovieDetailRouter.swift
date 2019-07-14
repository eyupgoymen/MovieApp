//
//  MovieDetailRouter.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

final class MovieDetailRouter {

    weak var viewController: UIViewController?

    static func createModule(movieId: Int) -> UIViewController {
        let router = MovieDetailRouter()
        let viewModel = MovieDetailViewModel(movieService: MovieService(), collectionService: CollectionService(), router: router)
        
        //View
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController" ) as! MovieDetailViewController
        
        //Injections
        router.viewController = controller
        controller.viewModel = viewModel
        controller.movieId = movieId
        
        return controller
    }

    //all routing methods up here...
    //func routeTo...()
    func routeToMovieDetail(movieId: Int) {
        let detailVC = MovieDetailRouter.createModule(movieId: movieId)
        self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}

