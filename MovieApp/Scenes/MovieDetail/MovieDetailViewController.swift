//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//


import Foundation
import UIKit

final class MovieDetailViewController : UIViewController {
    
    //MARK: View Model and Router
    var viewModel: MovieDetailViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }

    //MARK: UI objects
    @IBOutlet weak var tableView: UITableView!
    let imageView = UIImageView()
    
    //MARK: Variables
    var movieId: Int!
    var movie: Movie?
    var collection: CollectionResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegisters()
        setLayout()
        
        viewModel.fetchMovieDetails(movieId: movieId)
    }

    private func setRegisters() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MovieDetailCell", bundle: nil), forCellReuseIdentifier: "MovieDetailCell")
        tableView.register(UINib(nibName: "SimilarCollectionCells", bundle: nil), forCellReuseIdentifier: "SimilarCollectionCells")
    }
    
    private func setStretchyImage() {
        guard let posterPath = movie?.posterPath else { return }
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        imageView.kf.setImage(with: imageURL)
    }
}

//MARK: View Model Delegate
extension MovieDetailViewController : MovieDetailViewModelDelegate {
    func handleViewModelOutput(_ output: MovieDetailViewModelOutput) {
        switch output {
            case .showError(let error):
                alert(message: error.localizedDescription, title: "Error")
                showIndicator(boolVal: false)
            
            case .setLoading(let boolVal):
                showIndicator(boolVal: boolVal)
            
            case .movieDetailFetched(let movie):
                self.movie = movie
                setStretchyImage()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                //If collection exists...
                if let collectionId = movie.collection?.id {
                    viewModel.fetchCollection(collectionId: collectionId)
                } else {
                    showIndicator(boolVal: false) // otherwise dismiss the loader
                }
            
            case .collectionFetched(let collectionResponse):
                self.collection = collectionResponse
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }
    }
}

//MARK: Table view and collection view methods here
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movie == nil { return 0 }
        if collection != nil { return 4}
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch DetailCellSections.init(section: indexPath.row) {
            case .title?:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as! MovieDetailCell
                cell.configureCell(movie: movie!, cellType: .title)
                return cell
            case .rate?:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as! MovieDetailCell
                cell.configureCell(movie: movie!, cellType: .rate)
                return cell
            case .overview?:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as! MovieDetailCell
                cell.configureCell(movie: movie!, cellType: .overview)
                return cell
            case .similarMovies?:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarCollectionCells", for: indexPath) as! SimilarCollectionCells
                cell.configureCell(collection: collection)
                cell.delegate = self
                return cell
            default:
                fatalError("Unexpected cell index")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MovieDetailViewController: DetailCellDelegate {
    func navigateToMovieDetail(movieId: Int) {
        viewModel.navigateToMovie(movieId: movieId)
    }
}
