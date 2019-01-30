//
//  Navigator.swift
//  RappiTest
//
//  Created by Luis Arias on 1/30/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

protocol Navegable where Self:UIViewController {
  var navigator: Navigator? { get set }
}

class Navigator {
  
  enum Destination {
    case movieList
    case movieDetail(Movie)
  }
  
  let apiClient = ApiClient()
  let window: UIWindow
  lazy var tabViewController = UITabBarController()
  
  init(window: UIWindow) {
    self.window = window
    window.rootViewController = tabViewController
    window.makeKeyAndVisible()
  }
  
  func navigateTo(destination: Destination) {
    switch destination {
    case .movieList:
      let movieService = MovieService(apiClient: apiClient)
      let topRatedMoviesViewController = MoviesListViewController(viewModel: MoviesListViewModel(movieService: movieService))
      topRatedMoviesViewController.navigator = self
      let popularMovieViewController = MoviesListViewController(viewModel: MoviesListViewModel(movieService: movieService))
      popularMovieViewController.navigator = self
      let upcomingMoviesViewController = MoviesListViewController(viewModel: MoviesListViewModel(movieService: movieService))
      upcomingMoviesViewController.navigator = self
      
      topRatedMoviesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
      popularMovieViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
      upcomingMoviesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 2)
      
      tabViewController.viewControllers = [topRatedMoviesViewController, popularMovieViewController, upcomingMoviesViewController]
    case .movieDetail(let movie):
      let movieDetail = MovieDetailViewController(movie: movie)
      let navigationController = UINavigationController(rootViewController: movieDetail)
      movieDetail.navigator = self
      tabViewController.present(navigationController, animated: true, completion: nil)
    }
  }
}
