//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by We Write Software on 20/01/2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private let favoriteMovieEntityName = "FavoriteMovieData"
    private let genreEntityName = "MovieGenres"
    private let moviesEntityName = "Movies"
    private let popularsMoviesEntityName = "PopualMovies"
    private let latestEntityName = "LatestMovie"

    private init() {}

    //MARK: Geners
    func saveGenres(_ genre: GenreModel) {

        guard let context = context else {return}
        let entityDescription = NSEntityDescription.entity(forEntityName: genreEntityName, in: context)

        guard let entityDescription = entityDescription else {return}
        let genreObjc = NSManagedObject(entity: entityDescription, insertInto: context)
        genreObjc.setValue(genre.name, forKey: "name")
        genreObjc.setValue(genre.id, forKey: "Id")
        
        do{
            try context.save()
            print("Success")

        }catch{
            print(error.localizedDescription)
        }
    }
    
    func fetchGenres(completion: @escaping ([Int64: GenreDetails])->Void) {

        guard let context = context else {return}

        let fetchRequest = MovieGenre.fetchRequest()
     
        do{
           let allGeneres =  try context.fetch(fetchRequest)
            var genres: [Int64: GenreDetails] = [:]
            for data in allGeneres as [NSManagedObject]{
                
            if let id = data.value(forKey: "id") as? Int64,
               let name = data .value(forKey: "name") as? String{
               genres[id] = GenreDetails(id: id, name: name)
            }
                
            }
          completion(genres)
        }catch{
            print(error)
        }
    }
    
    //MARK: Save all movies the user load
    func save(_ movies: MovieModel) {
        
        guard let context = context else {return}
        guard let entityDescription = NSEntityDescription.entity(forEntityName: moviesEntityName, in: context) else {return}
              
        let moviesObject = NSManagedObject(entity: entityDescription, insertInto: context)
            moviesObject.setValue(movies.movieId, forKey: "movieId")
            moviesObject.setValue(movies.title, forKey: "title")
            moviesObject.setValue(movies.posterPath, forKey: "posterPath")
            moviesObject.setValue(movies.overview, forKey: "overview")
            moviesObject.setValue(movies.genreIDS, forKey: "genreIDS")
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func fetchMovieBy(genreId: Int64, completion: @escaping ([MovieDetails])->Void) {
        
        guard let context = context else {return}
        
        let fetchRequest = Movies.fetchRequest()
       
        do{
            var movies = [Int: MovieDetails]()
            let allMovies = try context.fetch(fetchRequest)
            for data in allMovies as [NSManagedObject]{
                if let movieId = data.value(forKey: "movieId") as? Int,
                   let title = data.value(forKey: "title") as? String,
                   let posterPath = data.value(forKey: "posterPath") as? String,
                   let overview = data.value(forKey: "overview") as? String,
                   let genreIDS = data.value(forKey: "genreIDS") as? [Int]{
                   let movieDetails = MovieDetails(adult: nil, backdropPath: nil, genreIDS: genreIDS, movieId: movieId, originalLanguage: nil, originalTitle: nil, overview: overview, popularity: nil, posterPath: posterPath, releaseDate: nil, title: title, video: nil, voteAverage: nil, voteCount: nil)
                     movies[movieId] = movieDetails
                }
            }
            let filterByGenreId = Array(movies.values.map{$0}).filter { movie in
                guard let genredIDS = movie.genreIDS else {return false}
                
                return genredIDS.contains(Int(genreId))
            }
            completion(filterByGenreId)
            
        }catch{
            print(error)
        }
    }

    //MARK: Popual Movie
    func savePopularsMovies(_ movieDetails: MovieModel) {
        
        guard let context = context else {return}
        guard let entityDescription = NSEntityDescription.entity(forEntityName: popularsMoviesEntityName, in: context) else {return}
        
        let popularMovieObject = NSManagedObject(entity: entityDescription, insertInto: context)
        
            popularMovieObject.setValue(movieDetails.movieId, forKey: "movieId")
            popularMovieObject.setValue(movieDetails.title, forKey: "title")
            popularMovieObject.setValue(movieDetails.posterPath, forKey: "posterPath")
            popularMovieObject.setValue(movieDetails.overview, forKey: "overview")
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func fetchPopularMovies(compeltion: @escaping ([MovieDetails])->Void) {
        
        guard let context = context else {return}
        let fetchRequest = PopualMovies.fetchRequest()
        
        do{
            let getPopularMovies = try context.fetch(fetchRequest)
            var popularMovies: [Int:MovieDetails] = [:]
            for data in getPopularMovies as [NSManagedObject]{
               if let movieId = data.value(forKey: "movieId") as? Int,
                  let overview = data.value(forKey: "overview") as? String,
                  let posterPath = data.value(forKey: "posterPath") as? String,
                  let title = data.value(forKey: "title") as? String{
                   popularMovies[movieId] = MovieDetails(adult: nil, backdropPath: nil, genreIDS: nil, movieId: movieId, originalLanguage: nil, originalTitle: nil, overview: overview, popularity: nil, posterPath: posterPath, releaseDate: nil, title: title, video: nil, voteAverage: nil, voteCount: nil)
               }
            }
            let toArray = Array(popularMovies.values.map{$0})
            compeltion(toArray)
        }catch{
            
        }
    }
    
    //MARK: Last Movie
    func saveLatestMovie(_ movieModel: MovieModel) {
        
        guard let context = context,
              let entityDescription = NSEntityDescription.entity(forEntityName: latestEntityName, in: context) else {return}
        let latestMovieObject = NSManagedObject(entity: entityDescription, insertInto: context)
            latestMovieObject.setValue(movieModel.movieId, forKey: "movieId")
            latestMovieObject.setValue(movieModel.title, forKey: "title")
            latestMovieObject.setValue(movieModel.posterPath, forKey: "posterPath")
            latestMovieObject.setValue(movieModel.overview, forKey: "overview")
        do{
            try context.save()
        }catch{
            print(error)
        }
        
    }
    
    func fetchLatestMovie(completion: @escaping (MovieDetails)->Void) {
        
        guard let context = context else {return}
        let fetchRequest = LatestMovie.fetchRequest()
        
        do{
            let getLatestMovie = try context.fetch(fetchRequest)
            var latestMovie: [String: MovieDetails] = [:]
            for data in getLatestMovie as [NSManagedObject]{
                if let movieId = data.value(forKey: "movieId") as? Int,
                   let title = data.value(forKey: "title") as? String,
                   let overview = data.value(forKey: "overview") as? String,
                   let posterPath = data.value(forKey: "posterPath") as? String{
                    latestMovie["latestMovie"] = MovieDetails(adult: nil, backdropPath: nil, genreIDS: nil, movieId: movieId, originalLanguage: nil, originalTitle: nil, overview: overview, popularity: nil, posterPath: posterPath, releaseDate: nil, title: title, video: nil, voteAverage: nil, voteCount: nil)
                }
                if let latestMovie = latestMovie.values.first{
                    completion(latestMovie)
                }
            }
        }catch{
            
        }
        
    }
    
    //MARK: Movies Favorite
    func saveFavorite(_ movieDetails: MovieModel, completion: @escaping (String)->Void) {

        guard let context = context else {return}
        guard let entityDescription = NSEntityDescription.entity(forEntityName: favoriteMovieEntityName, in: context) else {return}

        let favoriteMovieObj = NSManagedObject(entity: entityDescription, insertInto: context)

            favoriteMovieObj.setValue(movieDetails.movieId, forKey: "movieId")
            favoriteMovieObj.setValue(movieDetails.title, forKey: "title")
            favoriteMovieObj.setValue(movieDetails.posterPath, forKey: "posterPath")
            favoriteMovieObj.setValue(movieDetails.overview, forKey: "overview")

        do{
            try context.save()
            completion("Movie saved!👍🏻")
        }catch{
            completion("saved move failed \(error.localizedDescription)")
        }
    }

    func fecthFavorite(completion: @escaping ([MovieDetails]?, String?)->Void) {

        guard let context = context else {return}

        let movieFetchRequest = FavoriteMovie.fetchRequest()

        do{
            let getFavoriteMovies = try context.fetch(movieFetchRequest)
            var favorites: [Int: MovieDetails] = [:]
            for data in getFavoriteMovies as [NSManagedObject]{
                
                if let title = data.value(forKey: "title") as? String,
                   let overview = data.value(forKey: "overview") as? String,
                   let posterPath = data.value(forKey: "posterPath") as? String,
                   let movieId = data.value(forKey: "movieId") as? Int{
                    favorites[movieId] = MovieDetails(adult: nil, backdropPath: nil, genreIDS: nil, movieId: movieId, originalLanguage: nil, originalTitle: nil, overview: overview, popularity: nil, posterPath: posterPath, releaseDate: nil, title: title, video: nil, voteAverage: nil, voteCount: nil)
                }
            }
            let favoriteMovies = Array(favorites.values.map{$0})
            completion(favoriteMovies, nil)
        }catch{
            completion(nil, "Load favorite movie failed, try later")
        }
    }

    func deleteFavorite(_ movieId: Int, completion: @escaping (String)->Void) {

        guard let context = context else {return}
        
              let movieFetchRequest = FavoriteMovie.fetchRequest()
        
        do{
            let getFavoriteMovies = try context.fetch(movieFetchRequest)
            let favorites =  getFavoriteMovies as [NSManagedObject]
            let deleteItem = favorites.first { object in
                let id = object.value(forKey: "movieId") as! Int
                return movieId == id
            }
            context.delete(deleteItem!)
            try context.save()
            completion("Movie Deleted")
        }catch{
            completion(error.localizedDescription)
        }
    }
}
