//
//  MovieRequest.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

struct MovieRequest: Codable {
  
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let results: [Movie]
  
  enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case results
  }
}
