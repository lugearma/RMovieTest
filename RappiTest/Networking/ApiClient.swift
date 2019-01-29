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
}

protocol ApiClientProtocol {
  func getCategories(_ completion: @escaping (Result<Movie>) -> Void)
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
  
  func getCategories(_ completion: @escaping (Result<Category>) -> Void) {
    let parameters: [String: Any] = ["rows": 0, "facet": "theme", "timezone": "America/Mexico_City"]
    defaultRequest(ApiClientRouter.categories(parameters: parameters), completion)
  }
}

