//
//  Movie.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

struct Movie: Codable {
  
  let voteCount: Int
  let id: Int
  let video: Bool
  let voteAverage: Double
  let title: String
  let popularity: Double
  let posterPath: String?
  let language: String
  let originalTitle: String
  #warning("Check this")
  let genreId: [Int]
  let backdropPath: String?
  let adult: Bool
  let overview: String
  let releaseDate: Date
  
  enum CodingKeys: String, CodingKey {
    case voteCount = "vote_count"
    case id
    case video
    case voteAverage = "vote_average"
    case title
    case popularity
    case posterPath = "poster_path"
    case language = "original_language"
    case originalTitle = "original_title"
    case genreId = "genre_ids"
    case backdropPath = "backdrop_path"
    case adult
    case overview
    case releaseDate = "release_date"
  }
}
