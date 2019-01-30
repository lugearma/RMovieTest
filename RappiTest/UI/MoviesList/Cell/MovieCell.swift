//
//  MovieTableViewCell.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

final class MovieCell: UITableViewCell {
  
  var cellViewModel: MovieCellViewModel? {
    didSet {
      guard let movie = cellViewModel?.movie else { return }
      resetCell()
      setupCell(movie)
    }
  }
  
  @IBOutlet var movieTitleLabel: UILabel!
  @IBOutlet var movieVoteAverageLabel: UILabel!
  @IBOutlet var movieReleaseDateLabel: UILabel!
  @IBOutlet var moviePosterImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    accessoryType = .disclosureIndicator
  }
  
  private func setupCell(_ movie: Movie) {
    movieTitleLabel.text = movie.title
    movieVoteAverageLabel.text = String(movie.voteAverage)
    #warning("Set date as string")
    movieReleaseDateLabel.text = String("")
    cellViewModel?.getPosterImage()
  }
 
  func resetCell() {
    moviePosterImageView.image = UIImage(named: "placeholder")
  }
}

extension MovieCell: MovieCellViewModelDelegate {
  func didReceivePosterImage(_ image: UIImage?) {
    moviePosterImageView.image = image
  }
}