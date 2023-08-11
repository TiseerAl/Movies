//
//  PopualMovies+CoreDataProperties.swift
//  MovieApp
//
//  Created by We Write Software on 21/03/2023.
//
//

import Foundation
import CoreData


extension PopualMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PopualMovies> {
        return NSFetchRequest<PopualMovies>(entityName: "PopualMovies")
    }

    @NSManaged public var movieId: Int64
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var title: String?

}

extension PopualMovies : Identifiable {

}
