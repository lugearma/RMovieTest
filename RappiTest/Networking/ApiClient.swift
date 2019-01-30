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
  func requestPopularMovies(_ page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void)
  func requestTopRatedMovies(_ page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void)
  func requestUpcomingMovies(_ page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void)
  func requestPosterImageWithPath(_ path: String, _ completion: @escaping (Result<UIImage>) -> Void) -> URLSessionDataTask
}

extension ApiClientProtocol {
  
  @discardableResult
  func defaultRequest<T: Codable>(_ urlRequest: ApiClientRouter, _ completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask? {
    guard let request = try? urlRequest.asURLRequest() else {
      completion(Result { throw ApiClientError.unknown })
      return nil
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
    return task
  }
}

final class ApiClient: ApiClientProtocol {
  
  func requestPopularMovies(_ page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void) {
    let parameters: [String: Any] = ["page": page]
    defaultRequest(ApiClientRouter.popularMovies(parameters: parameters), completion)
  }
  
  func requestTopRatedMovies(_ page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void) {
    let parameters: [String: Any] = ["page": page]
    defaultRequest(ApiClientRouter.topRatedMovies(parameters: parameters), completion)
  }
  
  func requestUpcomingMovies(_ page: Int, _ completion: @escaping (Result<MovieRequest>) -> Void) {
    let parameters: [String: Any] = ["page": page]
    defaultRequest(ApiClientRouter.upcomingMovies(parameters: parameters), completion)
  }
  
  func requestPosterImageWithPath(_ path: String, _ completion: @escaping (Result<UIImage>) -> Void) -> URLSessionDataTask {
    let url = ApiClientRouter.posterImage(path: path).urlForImage()
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data else {
        completion(Result { throw ApiClientError.network })
        return
      }
      
      guard let image = UIImage(data: data) else {
        completion(Result { UIImage(named: "placeholder")! })
        return
      }
      completion(Result { image })
    }
    task.resume()
    return task
  }
}
