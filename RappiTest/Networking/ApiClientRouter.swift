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
  case posterImage(path: String)
}

extension ApiClientRouter {
  
  private var APIKey: String {
    guard let APIKey = Bundle.main.object(forInfoDictionaryKey: "API-Key") as? String else {
      preconditionFailure("Cannot get API-Key")
    }
    
    return APIKey
  }
  
  private var baseURLAsString: String {
    guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {
      preconditionFailure("Cannot get BaseURL")
    }
    
    return baseURL
  }
  
  private var APIVersion: Int {
    guard let APIVersion = Bundle.main.object(forInfoDictionaryKey: "API-Version") as? Int else {
      preconditionFailure("Cannot get API-Version")
    }
    
    return APIVersion
  }
  
  private var imageURL: String {
    guard let baseImageURL = Bundle.main.object(forInfoDictionaryKey: "BaseImageURL") as? String else {
      preconditionFailure("Cannot get API-Version")
    }
    
    return baseImageURL
  }
  
  private var path: (path: String, parameters: [String: Any]) {
    switch self {
    case .popularMovies(let parameters):
      return ("/\(APIVersion)/movie/popular", parameters)
    case .topRatedMovies(let parameters):
      return ("/\(APIVersion)/movie/top_rated", parameters)
    case .upcomingMovies(let parameters):
      return ("/\(APIVersion)/movie/upcoming", parameters)
    case .posterImage(let path):
      return (path, [:])
    }
  }
  
  func urlForImage() -> URL {
    let baseURL = URL(string: imageURL)
    guard let url = baseURL?.appendingPathComponent(path.path) else {
      preconditionFailure("Cannot get URL")
    }
    return url
  }
  
  func asURLRequest() throws -> URLRequest {
    let baseURL = URL(string: baseURLAsString)
    let urlAppendedPath = baseURL?.appendingPathComponent(path.path)
    let components = buildURLComponents(urlAppendedPath, withParameters: path.parameters)
    
    guard let url = components.url else {
      preconditionFailure("Cannot get URL")
    }
    
    let urlRequest = URLRequest(url: url)
    return urlRequest
  }
  
  private func buildURLComponents(_ url: URL?, withParameters parameters: Parameters) -> URLComponents {
    var urlComponents = URLComponents(url: url!, resolvingAgainstBaseURL: true)
    urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0, value: String(describing: $1))}
    urlComponents?.queryItems?.append(URLQueryItem(name: "api_key", value: APIKey))
    urlComponents?.queryItems?.append(URLQueryItem(name: "language", value: "en-US"))
    
    guard let components = urlComponents else {
      preconditionFailure("Cannot build components")
    }
    
    return components
  }
}

