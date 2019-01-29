//
//  ViewController.swift
//  RappiTest
//
//  Created by Luis Arias on 1/28/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let apiClient = APIClient()
    apiClient.getPopularMovies { result in
      switch result {
      case .failure(let error):
        print(error)
      case .success(let value):
        print(value)
      }
    }
  }
}

