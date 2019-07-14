//
//  MovieLayout.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//


import UIKit

//All layout functions and animations will be here
extension MoviesViewController {

     override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    func setLayout() {
        self.title = "Movies"
    }
}
