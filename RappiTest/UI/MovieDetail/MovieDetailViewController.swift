//
//  MovieDetailViewController.swift
//  RappiTest
//
//  Created by Luis Arias on 1/30/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {
  
  let movie: Movie
  
  @IBOutlet var posterImageView: UIImageView!
  @IBOutlet var overviewTextView: UITextView!
  
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
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
    overviewTextView.text = movie.overview
    posterImageView.image = movie.posterImage
  }
  
  @objc func dismissViewController() {
    dismiss(animated: true, completion: nil)
  }
}
