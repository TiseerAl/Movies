//
//  HomeViewController.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import UIKit

class GenresViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Propertis
    private let indicator = UIActivityIndicatorView()
    private var genres = [GenreModel]()
    private let coreData = CoreDataManager.shared
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
        fetchGenres()
    }
    
    private func configureUI() {
        
        navigationController?.title = "Genres"
        indicator.setup(view: view)
        indicator.startAnimating()
    }
    
    private func delegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchGenres() {
        
        apiService.fetchGeneres { [weak self] genres, errorMessage in
            self?.indicator.stopAnimating()
            guard let genres = genres else {
               // load from Local DB:
                self?.locadLocalGeneres()
                return}
       
            genres.forEach{
                //save genres is local DB
                self?.coreData.saveGenres($0)
            }
            self?.genres = genres
            self?.tableView.reloadData()
            //Save data service in core data:
        }
    }

    private func locadLocalGeneres() {
        
       // TODO: Favrotie
        CoreDataManager.shared.fetchGenres() { [weak self] genres in
            self?.genres = Array(genres.values.map{$0}).sorted(by: {$0.id < $1.id})
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == ConstantValue.SegueIdentifier.moviesByGenres{
            if let moviesViewController = segue.destination as? MoviesTableViewController{
                if let genresDetails = sender as? (genreId: Int64, genreTitle: String){
                    moviesViewController.genresDetails = genresDetails
                }
            }
        }
    }
    
    
}

//MARK: Table View delegates
extension GenresViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.cellIdentifier) as?
            GenreTableViewCell else {return UITableViewCell()}
        
            let genre = genres[indexPath.row]
            cell.configureCell(gernre: genre)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let genre = genres[indexPath.row]
        let tuple = (genreId: genre.id, genreTitle: genre.name)
        performSegue(withIdentifier: ConstantValue.SegueIdentifier.moviesByGenres, sender: tuple)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
