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
  func didThrow(_ error: Error)
}

final class MoviesListViewModel {
  
  let movieService: MovieService
  weak var delegate: MoviesListDelegate?
  private var currentPage = 1
  private var totalPages = 0
  private let section: MovieService.Section
  
  init(movieService: MovieService, section: MovieService.Section) {
    self.movieService = movieService
    self.section = section
  }
  
  func getMoviesBy(atPage page: Int = 1) {
    movieService.moviesBy(section, atPage: page) { result in
      switch result {
      case .failure(let error):
        self.delegate?.didThrow(error)
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
      getMoviesBy(atPage: currentPage)
    }
  }
}
