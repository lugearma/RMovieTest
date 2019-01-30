//
//  MovieDetailViewController.swift
//  RappiTest
//
//  Created by Luis Arias on 1/30/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController, Navegable {
  
  let movie: Movie
  var navigator: Navigator?
  
  init(movie: Movie) {
    self.movie = movie
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = movie.title
  }
}
