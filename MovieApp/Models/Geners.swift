//
//  Geners.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import Foundation

protocol GenreModel{
    
    var id: Int64 {get set}
    var name: String {get set}
}
//MARK: - Genre
class Genre: Codable{
    let genres: [GenreDetails]?
}

// MARK: - Genre Details
struct GenreDetails:GenreModel, Codable {
    
    var id: Int64
    var name: String
}
