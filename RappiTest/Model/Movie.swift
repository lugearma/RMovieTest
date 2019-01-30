//
//  Movie.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation
import UIKit.UIImage

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
  let genreId: [Int]
  let backdropPath: String?
  let adult: Bool
  let overview: String
  let releaseDate: String
  var date: Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let date = dateFormatter.date(from: releaseDate) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
  var posterImage: UIImage?
  
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
