//
//  Enums.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import Foundation

//Using enum for recognize the error type and handle it for example if the error comes from internet connection we load the data from Local DB
enum APIErrorMessage: String {
    
    case invalidURL = "Invalid URL"
    case generalMessage = "Something went wrong"
    case internerConnectionFailed = "Please check your interner connection"
    
}

enum Result<T>{
    
    case success(value: T)
    case failure(message: APIErrorMessage? = nil)
}


