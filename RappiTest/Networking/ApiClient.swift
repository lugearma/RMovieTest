//
//  ApiClient.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

enum ApiClientError: LocalizedError {
  case unknown
  case network
}

protocol ApiClientProtocol {
  func requestPopularMovies(_ page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void)
  func requestTopRatedMovies(_ page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void)
  func requestUpcomingMovies(_ page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void)
}

extension ApiClientProtocol {
  
  func defaultRequest<T: Codable>(_ urlRequest: ApiClientRouter, _ completion: @escaping (Result<T>) -> Void) {
    guard let request = try? urlRequest.asURLRequest() else {
      completion(Result { throw ApiClientError.unknown })
      return
    }
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      do {
        let json = try JSONDecoder().decode(T.self, from: data!)
        completion(Result { json })
      } catch {
        completion(Result { throw error })
      }
    }
    task.resume()
  }
}

final class APIClient: ApiClientProtocol {
  
  func requestPopularMovies(_ page: Int = 1, _ completion: @escaping (Result<MovieRequest>) -> Void) {
    let parameters: [String: Any] = ["page": page]
    defaultRequest(ApiClientRouter.popularMovies(parameters: parameters), completion)
  }
  
  func requestTopRatedMovies(_ page: Int = 1, _ completion: @escaping (Result<MovieRequest>) -> Void) {
    let parameters: [String: Any] = ["page": page]
    defaultRequest(ApiClientRouter.topRatedMovies(parameters: parameters), completion)
  }
  
  func requestUpcomingMovies(_ page: Int = 1, _ completion: @escaping (Result<MovieRequest>) -> Void) {
    let parameters: [String: Any] = ["page": page]
    defaultRequest(ApiClientRouter.upcomingMovies(parameters: parameters), completion)
  }
}

