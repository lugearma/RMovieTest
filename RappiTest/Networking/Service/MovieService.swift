//
//  MovieService.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation
import UIKit.UIImage

final class MovieService {
  
  enum Section {
    case popular
    case topRated
    case upcoming
  }
  
  let apiClient: ApiClientProtocol
  
  init(apiClient: ApiClientProtocol) {
    self.apiClient = apiClient
  }
  
  func moviesBy(_ clasification: Section, atPage page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void) {
    apiClient.requestMovies(for: clasification, atPage: page, completion)
  }
  
  func posterImageForMovie(imagePath: String, _ completion: @escaping (Result<UIImage>) -> Void) -> URLSessionDataTask {
    return apiClient.requestPosterImageWithPath(imagePath, completion)
  }
}
