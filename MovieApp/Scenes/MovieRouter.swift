//
//  MovieRouter.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

final class Movies {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let router = Movies()
        let movieService = MovieService()
        let viewModel = MovieViewModel(movieService: movieService)
       
        //View
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MovieViewController" ) as! MoviesViewController
        
        //Injections
        router.viewController = controller
        controller.router = router
        controller.viewModel = viewModel
        
        return UINavigationController(rootViewController: controller)
    }

    //all routing methods up here...
    //func routeTo...()
}

