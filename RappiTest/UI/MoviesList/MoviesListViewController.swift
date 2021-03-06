//
//  MoviesListViewController.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

final class MoviesListViewController: UIViewController, Navegable {
  
  var movies: [Movie] = []
  let viewModel: MoviesListViewModel
  var navigator: Navigator?
  var section: MovieService.Section = .popular
  
  @IBOutlet var moviesTableView: UITableView!
  
  init(viewModel: MoviesListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.viewModel.delegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.getMoviesBy()
    setupTableView()
  }
  
  private func setupTableView() {
    moviesTableView.registerNib(cellType: MovieCell.self)
    moviesTableView.delegate = self
    moviesTableView.dataSource = self
    moviesTableView.rowHeight = 120
  }
  
  private func loadNextPage() {
    viewModel.loadNextPage()
  }
}

// MARK: - UITableViewDataSource

extension MoviesListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: MovieCell = tableView.dequeueCell(indexPath: indexPath)
    let movie = movies[indexPath.row]
    let cellViewModel = MovieCellViewModel(movie: movie, movieService: viewModel.movieService)
    cellViewModel.delegate = cell
    cell.cellViewModel = cellViewModel
    
    if movies.count % 10 == 0 && indexPath.item == movies.count - 1 {
      loadNextPage()
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension MoviesListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as? MovieCell
    cell?.cellViewModel?.cancelPosterImageRequest()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedCell = tableView.cellForRow(at: indexPath) as! MovieCell
    var movieSelected = movies[indexPath.row]
    movieSelected.posterImage = selectedCell.moviePosterImageView.image
    navigator?.navigateTo(destination: .movieDetail(movieSelected))
  }
}

// MARK: - MoviesListDelegate

extension MoviesListViewController: MoviesListDelegate {
  func didReceiveMovies(_ movies: [Movie]) {
    self.movies += movies
    moviesTableView.reloadData()
  }
  
  func didThrow(_ error: Error) {
    print("Present Alert")
  }
}
