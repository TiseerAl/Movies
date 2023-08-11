//
//  ApiService.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import Foundation

final class ApiService: ApiClient{
    
    static let shared = ApiService()
    
    private init () {}
    
    func fetchGeneres(completion: @escaping ([GenreDetails]?, APIErrorMessage?)->Void) {
        let endPoint = ConstantValue.ApiValue.generes
        fetch(with: endPoint) { (result: Result<Genre>) in
            switch result {
            case .success(let value):
                if let genres = value.genres{
                    completion(genres, nil)
                }
            case .failure(let message):
              completion(nil, message)
            }
        }
    }
    
    func fetchMovies(genreId: Int64, completion: @escaping ([MovieDetails]?, APIErrorMessage?)->Void) {
        
        let endPoint = ConstantValue.ApiValue.moviesByGenreId.replacingOccurrences(of: "{genreId}", with: String(genreId))
        fetch(with: endPoint) { (result: Result<Movie>) in
            switch result {
            case .success(let value):
                if let movies = value.results{
                    completion(movies, nil)
                }
            case .failure(let message):
                completion(nil, message)
            }
        }
    }
    
    func fetchPopularMovies(completion: @escaping ([MovieDetails]?, APIErrorMessage?)->Void) {
        
        let endPoint = ConstantValue.ApiValue.popularMovie
        fetch(with: endPoint) { (result: Result<Movie>) in
            switch result {
            case .success(let value):
                completion(value.results, nil)
            case .failure(let message):
                completion(nil, message)
            }
        }
    }
    
    func fetchLatestMovie(completion: @escaping (MovieDetails?, APIErrorMessage?)->Void) {
        
        let endPoint = ConstantValue.ApiValue.latestMovie
        fetch(with: endPoint) { (resilt: Result<MovieDetails>) in
            switch resilt {
            case .success(let value):
                completion(value, nil)
            case .failure(let message):
                completion(nil, message)
            }
        }
        
    }
}
