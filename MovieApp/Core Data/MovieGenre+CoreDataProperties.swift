//
//  MovieGenre+CoreDataProperties.swift
//  MovieApp
//
//  Created by We Write Software on 03/03/2023.
//
//

import Foundation
import CoreData


extension MovieGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGenre> {
        return NSFetchRequest<MovieGenre>(entityName: "MovieGenres")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String

}

extension MovieGenre : Identifiable {

}
