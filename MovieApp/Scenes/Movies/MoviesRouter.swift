//
//  MoviesRouter.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

final class MoviesRouter {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let router = MoviesRouter()
        let viewModel = MoviesViewModel(movieService: MovieService(), router: router)
        
        //View
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController" ) as! MoviesViewController
        
        //Injections
        router.viewController = controller
        controller.viewModel = viewModel
        
        return UINavigationController(rootViewController: controller)
    }
    
    //all routing methods up here...
    //func routeTo...()
    func routeToMovieDetail(movieId: Int) {
        let detailVC = MovieDetailRouter.createModule(movieId: movieId)
        self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
