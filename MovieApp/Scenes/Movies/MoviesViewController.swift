//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//


import Foundation
import UIKit

final class MoviesViewController : UIViewController {
    
    //MARK: View Model and Router
    var viewModel: MoviesViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }

    //MARK: UI objects
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Variables
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setRegisters()
        setLayout()
        viewModel.loadView()
    }

    private func setRegisters() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
}

//MARK: View Model Delegate
extension MoviesViewController : MoviesViewModelDelegate {
    func handleViewModelOutput(_ output: MoviesViewModelOutput) {
        switch output {
            case .showError(let error):
                alert(message: error.localizedDescription, title: "Error")
            
            case .setLoading(let boolVal):
                showIndicator(boolVal: boolVal)
            
            case .moviesFetched(let movies):
                self.movies = movies
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
        }
    }
}

//MARK: Table view and collection view methods here
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configureCell(movie: movies[indexPath.row], cellType: .vertical)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 24 space for left and right
        // 24 space for inter space
        return CGSize(width: (self.collectionView.frame.width - 72 ) / 2, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToMovie(at: indexPath.row)
    }
}
