//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell{
    
    //MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: Propertis
    private var isTapped = false
    static let nibName = "MovieTableViewCell"
    static let cellIdentifier = "movieCell"
    var movie: MovieModel?
    var didLikeTapped: ((_ movie: MovieModel)->Void)?
    
    //MARK: - Action
    @IBAction func didFavoriteHeartTapped(_ sender: UIButton) {
        
        isTapped = !isTapped
        setupLikeButtonStyle(isTapped: isTapped)
        if let movie = movie{
            didLikeTapped?(movie)
        }
    }
    
   //MARK: Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configureCell(movie: MovieModel, isFavorite: Bool) {
        
        //Check movie type
        if isFavorite{
            //Like buttons tapped and fill heart red style
            setupLikeButtonStyle(isTapped: true)
        }
        titleLabel.text = movie.title ?? "N/A"
        if let path = movie.posterPath{
            ImageService.shared.loadImageFromCache(path: path) { [weak self] image in
                self?.movieImageView.image = image
            }
        }
    }
    
    func setupLikeButtonStyle(isTapped: Bool) {
        
        if isTapped{
            favoriteButton.tintColor = .red
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.isEnabled = false
        }
    }
    
}
