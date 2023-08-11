//
//  Movie.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import Foundation

protocol MovieModel{
    
    var title: String? {get set}
    var posterPath: String? {get set}
    var overview: String? {get set}
    var movieId: Int {get set}
    var genreIDS: [Int]? {get set}
}

//MARK: Moivie
struct Movie: Codable{
    
    let results: [MovieDetails]?
}

//MARK: Moivie Details
struct MovieDetails: Codable, MovieModel{
   
    let adult: Bool?
    let backdropPath: String?
    var genreIDS: [Int]?
    var movieId: Int
    let originalLanguage: String?
    let originalTitle: String?
    var overview: String?
    let popularity: Double?
    var posterPath: String?
    let releaseDate: String?
    var title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    var isFavorite: Bool?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case movieId = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}
