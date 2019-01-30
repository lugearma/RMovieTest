//
//  MovieCellViewModel.swift
//  RappiTest
//
//  Created by Luis Arias on 1/30/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol MovieCellViewModelDelegate: class {
  func didReceivePosterImage(_ image: UIImage?)
}

class MovieCellViewModel {
  
  let movie: Movie
  let movieService: MovieService
  weak var delegate: MovieCellViewModelDelegate?
  var dataTask: URLSessionDataTask?
  
  init(movie: Movie, movieService: MovieService) {
    self.movie = movie
    self.movieService = movieService
  }
  
  func getPosterImage() {
    dataTask = movieService.posterImageForMovie(imagePath: movie.posterPath ?? "") { [weak self] result in
      self?.dataTask = nil
      var image = UIImage(named: "placeholder")
      switch result {
      case .failure:
        break
      case .success(let value):
        image = value
      }
      DispatchQueue.main.async {
        self?.delegate?.didReceivePosterImage(image)
      }
    }
  }
  
  func cancelPosterImageRequest() {
    if let task = dataTask {
      task.cancel()
    }
  }
}
