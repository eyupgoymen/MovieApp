//
//  MovieDetailLayout.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//


import UIKit

//All layout functions and animations will be here
extension MovieDetailViewController {

     override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    func setLayout() {
        //Stretchy header
        tableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        imageView.image = UIImage(named: "dummy")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        //Transparant navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .white
        
        //Remove lines for empty cells
        tableView.tableFooterView = UIView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var y = 300 - (scrollView.contentOffset.y + 300)
        y = y < 120 ? 120 : y
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: y)
    }
}
