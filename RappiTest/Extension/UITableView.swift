//
//  UITableView.swift
//  RappiTest
//
//  Created by Luis Arias on 1/30/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
  
  func dequeueCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      preconditionFailure("Couldn't dequeue cell")
    }
    
    return cell
  }
  
  func registerNib(cellType: AnyClass) {
    guard let T = cellType as? UITableViewCell.Type else {
      preconditionFailure("Could'n cast value")
    }
    register(T.nib, forCellReuseIdentifier: T.identifier)
  }
}
