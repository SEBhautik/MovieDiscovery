//
//  MovieDetailViewController.swift
//  MovieDiscovery
//
//  Created by Bhautik Parmar on 21/04/25.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var viewModel: MovieDetailViewModel!

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        setupActivityIndicator()
        setupBindings()
        setupUI()
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.onImageLoadStarted = { [weak self] in
            self?.activityIndicator.startAnimating()
        }

        viewModel.onImageLoadFinished = { [weak self] in
            self?.activityIndicator.stopAnimating()
        }

        viewModel.onImageLoadFailed = { [weak self] message in
            self?.activityIndicator.stopAnimating()
            self?.showErrorAlert(message: message)
        }
    }

    private func setupUI() {
        titleLabel.text = viewModel.title
        dateLabel.text = "Release Date: \(viewModel.releaseDate)"
        overviewLabel.text = viewModel.overview

        loadPosterImage()
    }

    private func loadPosterImage() {
        guard let url = viewModel.posterURL else {
            posterImageView.image = UIImage(systemName: "photo")
            return
        }

        viewModel.onImageLoadStarted?()

        posterImageView.sd_setImage(with: url, placeholderImage: nil, options: [], completed: { [weak self] _, error, _, _ in
            if let error = error {
                self?.viewModel.onImageLoadFailed?(error.localizedDescription)
            } else {
                self?.viewModel.onImageLoadFinished?()
            }
        })
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Image Load Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
