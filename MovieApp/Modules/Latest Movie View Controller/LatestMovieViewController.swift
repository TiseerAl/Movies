//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import UIKit

class LatestMovieViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    //MARK: Properties
    var movie: MovieModel?
    var identifier: Int?
    private let coreData = CoreDataManager.shared
    private let apiService = ApiService.shared
    
    //MARK: Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        main()
        
    }
    
    //MARK: Functions
    private func main() {
        
        delegates()
        configure()
        fetchLatest()
    }

    private func configure() {
        
     tableView.separatorStyle = .none
     tableView.register(UINib(nibName: MovieDetailsTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MovieDetailsTableViewCell.cellIdentifier)
        
    }
    
    private func delegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchLatest() {
        
        apiService.fetchLatestMovie { [weak self] latestMovie, errorMessage in
            
            guard let latestMovie = latestMovie else {
                if errorMessage == .internerConnectionFailed{
                    self?.fetchLocalLatestMovie()
                    return
                }
                self?.appearDialog(title: "Failed", message: "please try later")
                return}
            self?.movie = latestMovie
            self?.coreData.saveLatestMovie(latestMovie)
            self?.tableView.reloadData()
        }
    }
    
    //MARK: Local DB:
    private func fetchLocalLatestMovie() {
        
        coreData.fetchLatestMovie { [weak self] movie in
            self?.movie = movie
        }
    }
    
}

extension LatestMovieViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.cellIdentifier) as? MovieDetailsTableViewCell else {fatalError()}
       
        guard let movie = movie else {return UITableViewCell()}
        cell.configureCell(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}
