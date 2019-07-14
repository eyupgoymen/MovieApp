//
//  MovieCell.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }
    
    private func setLayout() {
        self.layer.addShadow(radius: 6)
        self.layer.roundCorners(radius: 5)
        
        self.movieImageView.layer.cornerRadius = 5
        self.movieImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func configureCell(movie: Movie, cellType: MovieCellType) {
        movieTitleLabel.text = movie.title
        movieRateLabel.text = "Rate: \(movie.voteAverage)"
        
        guard let posterPath = movie.posterPath else { return }
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        movieImageView.kf.setImage(with: imageURL)
    }
}
