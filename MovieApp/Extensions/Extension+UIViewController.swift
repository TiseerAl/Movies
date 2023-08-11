//
//  Extension+UIViewController.swift
//  MovieDB
//
//  Created by We Write Software on 09/01/2023.
//

import Foundation
import UIKit

extension UIViewController{
    
    func appearDialog(title: String, message: String) {
        
        let alertVieController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel)
            alertVieController.addAction(action)
        present(alertVieController, animated: true)
    }
    
}
