//
//  LatestMovie+CoreDataProperties.swift
//  MovieApp
//
//  Created by We Write Software on 22/03/2023.
//
//

import Foundation
import CoreData


extension LatestMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LatestMovie> {
        return NSFetchRequest<LatestMovie>(entityName: "LatestMovie")
    }

    @NSManaged public var movieId: Int
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var title: String?
    @NSManaged public var genreIDS: [Int]?

}

extension LatestMovie : Identifiable {

}
