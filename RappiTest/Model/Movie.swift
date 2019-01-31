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
  
  let voteCount: Int?
  let id: Int?
  let voteAverage: Double?
  let title: String?
  let posterPath: String?
  let overview: String?
  let releaseDate: String?
  var date: Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let date = dateFormatter.date(from: releaseDate ?? "") else {
      preconditionFailure("Wrong format")
    }
    return date
  }
  var posterImage: UIImage?
  
  enum CodingKeys: String, CodingKey {
    case voteCount = "vote_count"
    case id
    case voteAverage = "vote_average"
    case title
    case posterPath = "poster_path"
    case overview
    case releaseDate = "release_date"
  }
}
