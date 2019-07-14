//
//  SimilarCollectionCells.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 14.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

class SimilarCollectionCells: UITableViewCell {

    var collection: CollectionResponse!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: DetailCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setRegisters()
    }
    
    private func setRegisters() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
    
    func configureCell(collection: CollectionResponse!) {
        self.collection = collection
    }
}

extension SimilarCollectionCells: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configureCell(movie: collection.movies[indexPath.row], cellType: .vertical)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: self.collectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navigateToMovieDetail(movieId: collection.movies[indexPath.row].id)
    }
}
