//
//  FavoriteMovieViewController.swift
//  MovieApp
//
//  Created by We Write Software on 20/01/2023.
//

import UIKit

class FavoriteMovieViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    //MARK: Properties
    private let coreData = CoreDataManager.shared
    private var favorites = [MovieDetails]()
//
    //MARK: Life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        main()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: Functions
    private func main() {

        fetchFavoriteMovies()
        setupTableView()

    }

    private func setupTableView() {

        tableView.register(UINib(nibName: MovieTableViewCell.nibName, bundle: nil), forCellReuseIdentifier:  MovieTableViewCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
   

    private func fetchFavoriteMovies() {

        coreData.fecthFavorite { [weak self] favorites, errorMessage in
            guard let favorites = favorites else {
                self?.appearDialog(title: "Error occured", message: errorMessage ?? "Try later")
                return
            }
            
            self?.favorites = favorites
            self?.tableView.reloadData()
        }
     }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == ConstantValue.SegueIdentifier.movieDetails{
            if let movieDetailsMovieController = segue.destination as? MovieDetailsTableViewController{
                if let movie = sender as? MovieModel{
                    movieDetailsMovieController.movie = movie
                }
            }
        }
    }
}

//MARK: - Table View Delegate
extension FavoriteMovieViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellIdentifier) as?  MovieTableViewCell else {return UITableViewCell()}
            let movie = favorites[indexPath.row]
            cell.movie = movie
            cell.configureCell(movie: movie, isFavorite: true)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = favorites[indexPath.row]
        performSegue(withIdentifier: ConstantValue.SegueIdentifier.movieDetails, sender: movie)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let movie = favorites[indexPath.row]
            CoreDataManager.shared.deleteFavorite(movie.movieId) { message in
                self.fetchFavoriteMovies()
                self.tableView.reloadData()
                self.appearDialog(title: "Movie Delted", message: "\(movie.title ?? "") removed from your favorite list")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 250
    }
}
