//
//  MovieGenres+CoreDataProperties.swift
//  MovieApp
//
//  Created by We Write Software on 05/03/2023.
//
//

import Foundation
import CoreData


extension MovieGenres{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGenres> {
        return NSFetchRequest<MovieGenres>(entityName: "MovieGenres")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64

}

extension MovieGenres : Identifiable {

}
