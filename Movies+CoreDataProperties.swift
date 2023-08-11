//
//  Movies+CoreDataProperties.swift
//  MovieApp
//
//  Created by We Write Software on 05/03/2023.
//
//

import Foundation
import CoreData


extension Movies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movies> {
        return NSFetchRequest<Movies>(entityName: "Movies")
    }

    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var overview: String?
    @NSManaged public var movieId: Int
    @NSManaged public var genreIDS: [Int]?
  
}

extension Movies : Identifiable {

}
