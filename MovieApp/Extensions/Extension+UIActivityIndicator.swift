//
//  Extension+UIActivityIndicator.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import UIKit

extension UIActivityIndicatorView{
    
    func setup(view: UIView) {
        
        view.addSubview(self)
        startAnimating()
        self.center = view.center
        hidesWhenStopped = true
    }
}
