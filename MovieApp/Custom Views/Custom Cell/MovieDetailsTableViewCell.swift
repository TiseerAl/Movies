//
//  MovieDetailsTableViewCell.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import Foundation
import UIKit

class MovieDetailsTableViewCell: UITableViewCell{
    
    //MARK: Ouetlet
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    //MARK: Properties
    static var nibName = "MovieDetailsTableViewCell"
    static var cellIdentifier = "movieDetails"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        selectionStyle = .none
    }
    
    //MARK: Functions
    func configureCell(movie: MovieModel) {
        
        movieTitleLabel.text = movie.title ?? "N/A"
        if let path = movie.posterPath{
            ImageService.shared.loadImageFromCache(path: path) { [weak self] image in
                self?.movieImageView.image = image
            }
        }else{
            movieImageView.image = UIImage(systemName: "photo.fill")
        }
        
        if movie.overview == ""{
            movieOverviewLabel.text = "Description unavaillable yet"
        }else{
            movieOverviewLabel.text = movie.overview ?? "N/A"
        }
    }
}
