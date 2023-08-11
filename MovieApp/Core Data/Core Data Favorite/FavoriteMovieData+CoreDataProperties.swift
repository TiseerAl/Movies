//
//  FavoriteMovieData+CoreDataProperties.swift
//  MovieApp
//
//  Created by We Write Software on 05/03/2023.
//
//

import Foundation
import CoreData


extension FavoriteMovieData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovieData> {
        return NSFetchRequest<FavoriteMovieData>(entityName: "FavoriteMovieData")
    }

    @NSManaged public var movieId: Int64
    @NSManaged public var overview: String?
    @NSManaged public var postPath: String?
    @NSManaged public var title: String?

}

extension FavoriteMovieData : Identifiable {

}
