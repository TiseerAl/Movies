//
//  GenreTableViewCell.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import Foundation
import UIKit

class GenreTableViewCell: UITableViewCell{
    
    //MARK: - Outlets
    @IBOutlet weak var genreTitleLabel: UILabel!
    
    //MARK: Properties
    static let cellIdentifier = "genreCell"
    
    func configureCell(gernre: GenreModel) {
        
        genreTitleLabel.text = gernre.name
    }
}
