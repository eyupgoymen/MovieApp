//
//  MovieDetailCell.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 14.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {
    
    @IBOutlet weak var cellTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(movie: Movie, cellType: DetailCellSections) {
        switch cellType {
            case .title:
                cellTextLabel.text = movie.title
                cellTextLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            case .overview:
                cellTextLabel.text = movie.overview
                cellTextLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                cellTextLabel.textColor = .lightGray
            case .rate:
                cellTextLabel.text = "Rate: \(movie.voteAverage)"
                cellTextLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
                cellTextLabel.textColor = .darkGray
            default:
                break
        }
    }
}
