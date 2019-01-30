//
//  Movie+CoreDataProperties.swift
//  RappiTest
//
//  Created by Luis Arias on 1/30/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterImage: NSData?

}
