//
//  MoviesListViewModel.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

protocol MoviesListDelegate: class {
  func didReceiveMovies(_ movies: [Movie])
}

final class MoviesListViewModel {
  
  let movieService: MovieService
  weak var delegate: MoviesListDelegate?
  private var currentPage = 1
  private var totalPages = 0
  private var clasification: MovieService.Section = .popular
  
  init(movieService: MovieService) {
    self.movieService = movieService
  }
  
  func getMoviesBy(clasification: MovieService.Section, atPage page: Int = 1) {
    movieService.moviesBy(clasification, atPage: page) { result in
      switch result {
      case .failure:
        preconditionFailure("Present alert")
      case .success(let value):
        self.totalPages = value.totalPages
        DispatchQueue.main.async {
          self.delegate?.didReceiveMovies(value.results)
        }
      }
    }
  }
  
  func loadNextPage() {
    currentPage += 1
    if currentPage <= totalPages {
      getMoviesBy(clasification: clasification, atPage: currentPage)
    }
  }
}
