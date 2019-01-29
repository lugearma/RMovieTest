//
//  ApiClientRouter.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

enum ApiClientRouter {
  case popularMovies(parameters: Parameters)
  case topRatedMovies(parameters: Parameters)
  case upcomingMovies(parameters: Parameters)
}

extension ApiClientRouter {
  
  var APIKey: String {
    guard let APIKey = Bundle.main.object(forInfoDictionaryKey: "API-Key") as? String else {
      preconditionFailure("Cannot get API-Key")
    }
    
    return APIKey
  }
  
  var baseURLAsString: String {
    guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {
      preconditionFailure("Cannot get BaseURL")
    }
    
    return baseURL
  }
  
  var APIVersion: Int {
    guard let APIVersion = Bundle.main.object(forInfoDictionaryKey: "API-Version") as? Int else {
      preconditionFailure("Cannot get API-Version")
    }
    
    return APIVersion
  }
  
  func asURLRequest() throws -> URLRequest {
    let result: (path: String, parameters: [String: Any]) = {
      switch self {
      case .popularMovies(let parameters):
        #warning("Check way to remove hard coded string")
        return ("/\(APIVersion)/movie/popular", parameters)
      case .topRatedMovies(let parameters):
        return ("/\(APIVersion)/movie/popular", parameters)
      case .upcomingMovies(let parameters):
        return ("/\(APIVersion)/movie/popular", parameters)
      }
    }()
    
    let baseURL = URL(string: baseURLAsString)
    let urlAppendedPath = baseURL?.appendingPathComponent(result.path)
    var components = URLComponents(url: urlAppendedPath!, resolvingAgainstBaseURL: true)
    components?.queryItems = result.parameters.map { URLQueryItem(name: $0, value: String(describing: $1))}
    components?.queryItems?.append(URLQueryItem(name: "api_key", value: APIKey))
    guard let url = components?.url else {
      preconditionFailure("Cannot get URL")
    }
    let urlRequest = URLRequest(url: url)
    return urlRequest
  }
}

