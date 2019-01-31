//
//  ApiClient.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation
import UIKit

enum ApiClientError: LocalizedError {
  case unknown
  case network
}

protocol ApiClientProtocol {
  func requestMovies(for section: MovieService.Section, atPage page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void)
  func requestPosterImageWithPath(_ path: String, _ completion: @escaping (Result<UIImage>) -> Void) -> URLSessionDataTask
}

extension ApiClientProtocol {
  
  @discardableResult
  func defaultRequest(_ urlRequest: ApiClientRouter, _ completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    guard let request = try? urlRequest.asURLRequest() else {
      preconditionFailure("Cannot get request")
    }
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
    task.resume()
    return task
  }
  
  func defaultJSONDecoder<T: Codable>(data: Data?, _ completion: @escaping (Result<T>) -> Void) {
    do {
      let json = try JSONDecoder().decode(T.self, from: data!)
      completion(Result { json })
    } catch {
      completion(Result { throw error })
    }
  }
}

final class ApiClient: ApiClientProtocol {
  
  func requestMovies(for section: MovieService.Section, atPage page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void) {
    let parameters: [String: Any] = ["page": page]
    let router: ApiClientRouter
    
    switch section {
    case .popular:
      router = .popularMovies(parameters: parameters)
    case .topRated:
      router = .topRatedMovies(parameters: parameters)
    case .upcoming:
      router = .upcomingMovies(parameters: parameters)
    }
    
    defaultRequest(router) { (data, _, error) in
      guard
        error == nil,
        let data = data else {
          completion(Result { throw ApiClientError.network })
          return
      }
      self.defaultJSONDecoder(data: data, completion)
    }
  }
  
  func requestPosterImageWithPath(_ path: String, _ completion: @escaping (Result<UIImage>) -> Void) -> URLSessionDataTask {
    return defaultRequest(ApiClientRouter.posterImage(path: path)) { (data, _, error) in
      guard
        error == nil,
        let data = data,
      let image = UIImage(data: data) else {
        completion(Result { UIImage(named: "placeholder")! })
        return
      }
      
      completion(Result { image })
    }
  }
}
