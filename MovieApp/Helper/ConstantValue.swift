//
//  ConstantValue.swift
//  MovieDB
//
//  Created by We Write Software on 09/01/2023.
//

import Foundation
struct ConstantValue{

    struct SegueIdentifier{
        
        static let register = "register"
        static let home = "home"
        static let moviesByGenres = "moviesByGenres"
        static let movieDetails = "movieDetails"
    }
    
    struct ApiValue{
        
        static let baseUrl = "https://api.themoviedb.org/3/"
        static let apiKey = "?api_key=f61c20714fe7442430383dedf4b02f07"
        
        //End Points
        static let generes = "genre/movie/list\(apiKey)"
        static let moviesByGenreId = "discover/movie\(apiKey)&with_genre={genreId}"
        static let popularMovie = "movie/popular\(apiKey)"
        static let latestMovie = "movie/latest\(apiKey)"
    }
}


