//
//  ApiClientRouter.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

enum ApiConstant: String {
  case apiKey = "API-Key"
  case baseURL = "BaseURL"
  case apiVersion = "API-Version"
  case baseImageURL = "BaseImageURL"
}

extension ApiConstant {
  var value: String {
    let key = self.rawValue
    guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
      preconditionFailure("Cannot get value for key \(key)")
    }
    
    return value
  }
}

enum ApiClientRouter {
  case popularMovies(parameters: Parameters)
  case topRatedMovies(parameters: Parameters)
  case upcomingMovies(parameters: Parameters)
  case posterImage(path: String)
}

extension ApiClientRouter {
  
  private var path: (path: String, parameters: [String: Any]) {
    switch self {
    case .popularMovies(let parameters):
      return ("/\(ApiConstant.apiVersion.value)/movie/popular", parameters)
    case .topRatedMovies(let parameters):
      return ("/\(ApiConstant.apiVersion.value)/movie/top_rated", parameters)
    case .upcomingMovies(let parameters):
      return ("/\(ApiConstant.apiVersion.value)/movie/upcoming", parameters)
    case .posterImage(let path):
      return (path, [:])
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    var url: URL?
    switch self {
    case .posterImage:
      let baseURL = URL(string: ApiConstant.baseImageURL.value)
      url = baseURL?.appendingPathComponent(path.path)
    default:
      let baseURL = URL(string: ApiConstant.baseURL.value)
      let urlAppendedPath = baseURL?.appendingPathComponent(path.path)
      let components = buildURLComponents(urlAppendedPath, withParameters: path.parameters)
      url = components.url
    }
    
    guard let URL = url else {
      preconditionFailure("Cannot get url from \(String(describing: url))")
    }
    let urlRequest = URLRequest(url: URL)
    return urlRequest
  }
  
  private func buildURLComponents(_ url: URL?, withParameters parameters: Parameters) -> URLComponents {
    var urlComponents = URLComponents(url: url!, resolvingAgainstBaseURL: true)
    urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0, value: String(describing: $1))}
    urlComponents?.queryItems?.append(URLQueryItem(name: "api_key", value: ApiConstant.apiKey.value))
    urlComponents?.queryItems?.append(URLQueryItem(name: "language", value: "en-US"))
    
    guard let components = urlComponents else {
      preconditionFailure("Cannot build components")
    }
    
    return components
  }
}

