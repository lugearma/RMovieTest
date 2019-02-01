//
//  RappiTestTests.swift
//  RappiTestTests
//
//  Created by Luis Arias on 1/28/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import XCTest
@testable import RappiTest

class RappiTestTests: XCTestCase {
  
  var apiClient: ApiClientProtocol!
  
  override func setUp() {
    apiClient = ApiClient()
  }
  
  func testRequestMoviesForPopularSection() {
    let exp = expectation(description: "Request movies expectation")
    apiClient.requestMovies(for: .popular, atPage: 1) { result in
      switch result {
      case .failure(let error):
        XCTFail(error.localizedDescription)
      case .success(let value):
        XCTAssertNotNil(value.results.first)
        XCTAssertNotNil(value.results.first?.overview)
        XCTAssertNotNil(value.results.first?.title)
        XCTAssertNotNil(value.results.first?.posterPath)
        XCTAssertNotNil(value.results.first?.releaseDate)
      }
      exp.fulfill()
    }
    
    wait(for: [exp], timeout: 5)
  }
  
  func testRequestMoviesForTopRatedSection() {
    let exp = expectation(description: "Request movies expectation")
    apiClient.requestMovies(for: .topRated, atPage: 1) { result in
      switch result {
      case .failure(let error):
        XCTFail(error.localizedDescription)
      case .success(let value):
        XCTAssertNotNil(value.results.first)
        XCTAssertNotNil(value.results.first?.overview)
        XCTAssertNotNil(value.results.first?.title)
        XCTAssertNotNil(value.results.first?.posterPath)
        XCTAssertNotNil(value.results.first?.releaseDate)
      }
      exp.fulfill()
    }
    
    wait(for: [exp], timeout: 5)
  }
  
  func testRequestMoviesForUpcomingSection() {
    let exp = expectation(description: "Request movies expectation")
    apiClient.requestMovies(for: .upcoming, atPage: 1) { result in
      switch result {
      case .failure(let error):
        XCTFail(error.localizedDescription)
      case .success(let value):
        XCTAssertNotNil(value.results.first)
        XCTAssertNotNil(value.results.first?.overview)
        XCTAssertNotNil(value.results.first?.title)
        XCTAssertNotNil(value.results.first?.posterPath)
        XCTAssertNotNil(value.results.first?.releaseDate)
      }
      exp.fulfill()
    }
    
    wait(for: [exp], timeout: 5)
  }
  
  func testRequestImageForGivenPath() {
    let path = "/d4KNaTrltq6bpkFS01pYtyXa09m.jpg"
    let exp = expectation(description: "Request image for given path")
    let _ = apiClient.requestPosterImageWithPath(path) { result in
      switch result {
      case .failure(let error):
        XCTFail(error.localizedDescription)
      case .success(let value):
        XCTAssertTrue(value != UIImage(named: "placeholder")!)
      }
      exp.fulfill()
    }
    
    wait(for: [exp], timeout: 5)
  }
}
