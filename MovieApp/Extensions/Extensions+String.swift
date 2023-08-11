//
//  Extensions+String.swift
//  MovieDB
//
//  Created by We Write Software on 09/01/2023.
//

import Foundation

extension String{
    
  func emailValidateContent()->Bool{
    
     //MARK: @Email
     let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
     let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
     let isValidEmail = emailPred.evaluate(with: self)
     
    return !isValidEmail ? false : true
        
  }
}
