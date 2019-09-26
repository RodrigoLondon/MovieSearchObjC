//
//  MovieSearchTableViewCell.swift
//  MovieSearchObjC1
//
//  Created by Lewis Jones on 04/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation
import UIKit


class MovieSearchTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: RPAMovie? {
        didSet {
            guard let movie = movie else { return }
            titleLabel.text = movie.title
            ratingLabel.text = "Rating: \(String(describing: movie.rating))"
            overviewLabel.text = movie.overview
            
            RPAMovieController.shared().fetchPosterImage(movie) { [weak self] (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self?.posterImageView.image = image
                    }
                } else {
                    print("Image was nil")
                }
            }
        }
    }
}
