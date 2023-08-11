//
//  TableViewController.swift
//  MovieApp
//
//  Created by We Write Software on 30/03/2023.
//

import UIKit

//MARK: Fetching movies by genre ID
class MoviesTableViewController: UITableViewController {

    //MARK: Properties
    var genresDetails: (genreId: Int64, genreTitle: String)?
    private var movies = [MovieModel]()
    private let coreDataService = CoreDataManager.shared
    private let apiService = ApiService.shared
    private var indicator = UIActivityIndicatorView()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        main()
        
    }
    
    //MARK: Functions
    private func main() {
        
        guard let genresDetails = genresDetails else {return}
        let genreId = genresDetails.genreId
        let genreTitle = genresDetails.genreTitle
        title = genreTitle
        indicator.setup(view: view)
        registerCell()
        fetchMovies(genreId: genreId)
    }
    
    private func registerCell() {
        
        tableView.register(UINib(nibName: MovieTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.cellIdentifier)
    }
    
    private func fetchMovies(genreId: Int64) {
        
        apiService.fetchMovies(genreId: genreId) { [weak self] movies, errorMessage in
            self?.indicator.stopAnimating()
            guard let movies = movies else {
                switch errorMessage{
                case .internerConnectionFailed:
                    //load from local DB:
                    self?.loadLocalMovies(genreId: genreId, errorMessage: errorMessage?.rawValue ?? "")
                default:
                    self?.appearDialog(title: "Load Movie Failed", message: errorMessage?.rawValue ?? "")
                }
                return}
            self?.movies = movies
            self?.tableView.reloadData()
            //save movies in local DB:
            movies.forEach{self?.coreDataService.save($0)}
        }
    }

    private func loadLocalMovies(genreId: Int64, errorMessage: String) {
        
        coreDataService.fetchMovieBy(genreId: genreId) { [weak self] movies in
            self?.movies = movies
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == ConstantValue.SegueIdentifier.movieDetails{
            if let movieDetailViewController = segue.destination as? MovieDetailsTableViewController,
                let movie = sender as? MovieModel{
                movieDetailViewController.movie = movie
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellIdentifier) as? MovieTableViewCell else {return UITableViewCell()}
        
            let movie = movies[indexPath.row]
            cell.movie = movie
            cell.configureCell(movie: movie, isFavorite: false)
        cell.didLikeTapped = { [weak self] movie in
            self?.coreDataService.saveFavorite(movie, completion: { message in
                self?.appearDialog(title: "Movie save", message: "\(movie.title ?? "") has been saved as Favorite")
            })
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: ConstantValue.SegueIdentifier.movieDetails, sender: movie)
                
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
   
}
