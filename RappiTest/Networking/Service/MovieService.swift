//
//  MovieService.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

#warning("Change this enum name")
enum MovieClasification {
  case popular
  case topRated
  case upcoming
}

final class MovieService {
  
  let apiClient: ApiClientProtocol
  
  init(apiClient: ApiClientProtocol) {
    self.apiClient = apiClient
  }
  
  func moviesBy(_ clasification: MovieClasification, atPage page: Int = 1, _ completion: @escaping (Result<MovieRequest>) -> Void) {
    switch clasification {
    case .popular:
      apiClient.requestPopularMovies(page, completion)
    case .topRated:
      apiClient.requestTopRatedMovies(page, completion)
    case .upcoming:
      apiClient.requestUpcomingMovies(page, completion)
    }
  }
}
