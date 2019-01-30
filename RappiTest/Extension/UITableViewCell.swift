//
//  UITableViewCell.swift
//  RappiTest
//
//  Created by Luis Arias on 1/30/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit.UITableViewCell

extension UITableViewCell {
  
  static var identifier: String {
    return String(describing: self.self)
  }
  
  static var nib: UINib? {
    return UINib(nibName: identifier, bundle: nil)
  }
}
