//
//  FavoriteMovie+CoreDataProperties.swift
//  MovieApp
//
//  Created by We Write Software on 20/01/2023.
//
//

import Foundation
import CoreData

extension FavoriteMovie{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovieData")
    }

    @NSManaged var movieId: Int
    @NSManaged var title: String?
    @NSManaged var posterPath: String?
    @NSManaged var overview: String?
    @NSManaged public var genreIDS: [Int]?
   
}

extension FavoriteMovie : Identifiable {

}
