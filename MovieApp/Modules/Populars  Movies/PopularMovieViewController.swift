//
//  MoviesViewController.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import UIKit

class PopularMovieViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Propertis
    private let coreData = CoreDataManager.shared
    private var movies = [MovieDetails]()
    private var favoritesMovie = [MovieDetails]()
    private let apiService = ApiService.shared
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        main()
    }
    
    //MARK: Functions
    private func main() {
       
        delegates()
        configureUI()
    
    }
    
    private func configureUI() {
        
        fetchPopularMovies()
        fetchFavoritesMovies()
        tableView.register(UINib(nibName: MovieTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.cellIdentifier)
    }
    
    private func delegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: Service fetching
    private func fetchPopularMovies() {
        
        apiService.fetchPopularMovies { [weak self] movies, errorMessage in
            guard let movies = movies else {
                switch errorMessage{
                case .internerConnectionFailed:
                    self?.loadPopualMovies()
                default:
                    self?.appearDialog(title: "Load Movie Failed", message: errorMessage?.rawValue ?? "")
                }
                return
            }
            self?.movies = movies
            self?.tableView.reloadData()
            //save movies in local DB:
            movies.forEach{self?.coreData.savePopularsMovies($0)}
        }
    }
    
    private func fetchFavoritesMovies() {

        CoreDataManager.shared.fecthFavorite { [weak self] favoritesMovie, errorMessage in
            guard let favoritesMovie = favoritesMovie else {
                self?.appearDialog(title: "Error Occured", message: errorMessage ?? "")
                return}
            self?.favoritesMovie = favoritesMovie
        }
    }

    //MARK: Core Data fetching
    private func loadPopualMovies() {
        
        coreData.fetchPopularMovies { [weak self] movies in
            self?.movies = movies
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == ConstantValue.SegueIdentifier.movieDetails{
            if let movieDetailsViewController = segue.destination as? MovieDetailsTableViewController{
                if let movie = sender as? MovieDetails{
                    movieDetailsViewController.movie = movie
                }
            }
        }
    }
}

//MARK: - Table View Delegates
extension PopularMovieViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellIdentifier) as? MovieTableViewCell else {return UITableViewCell()}
            let movie = movies[indexPath.row]
            cell.movie = movie
        cell.configureCell(movie: movie, isFavorite: false)
        
        //search the favorite movie in movie API data source to mark heart button
        if let _ = favoritesMovie.first(where: {$0.movieId == movie.movieId}){
            cell.setupLikeButtonStyle(isTapped: true)
        }else{
            cell.setupLikeButtonStyle(isTapped: false)
        }

        cell.didLikeTapped = { movie in
            CoreDataManager.shared.saveFavorite(movie) { [weak self] error in
                self?.appearDialog(title: "Movie save", message: "\(movie.title ?? "") has been saved as Favorite")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: ConstantValue.SegueIdentifier.movieDetails, sender: movie)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
