//
//  Result.swift
//  RappiTest
//
//  Created by Luis Arias on 1/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

enum Result<Value> {
  case success(Value)
  case failure(Error)
}

extension Result {
  init(_ capturing: () throws -> Value) {
    do {
      self = .success(try capturing())
    } catch {
      self = .failure(error)
    }
  }
}

