//
//  MovieTableViewCell.swift
//  MovieDiscovery
//
//  Created by Bhautik Parmar on 21/04/25.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseDate ?? "N/A"

        if let path = movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w200\(path)")
            posterImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        } else {
            posterImageView.image = UIImage(systemName: "photo")
        }
    }
}
