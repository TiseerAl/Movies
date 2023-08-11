//
//  ImageService.swift
//  MovieDB
//
//  Created by We Write Software on 13/01/2023.
//

import UIKit

//refernce to NSCache onject
let imageCache = NSCache<NSString, UIImage>()

public class ImageService {
    
    public static let shared = ImageService()
    private let basrUrl = "https://image.tmdb.org/t/p/w500/"
    
    private init() {}
   
     func loadImageFromCache(path: String ,completios: @escaping (UIImage?)->Void) {
        
        //If the image local in the cache loaded from cache
        if let url = URL(string: "\(basrUrl)\(path)") {
            
            if let imageCache = imageCache.object(forKey: NSString(string: url.absoluteString)){
                completios(imageCache)
                return
            }
            
            let request = URLRequest(url: url)
    
            //If the image doe's not local in storage download from server
            let session = URLSession.shared
            session.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil{
                        completios(UIImage(systemName: "person.fill"))
                        return
                    }
                    guard let data = data else {return}
                    let imageToCache = UIImage(data: data)
                    if imageToCache != nil{
                        completios(imageToCache)
                        //save the image inside the local storage:
                        imageCache.setObject(imageToCache!, forKey: NSString(string: url.absoluteString))
                    }else{
                        //placeholder image
                        completios(UIImage(systemName: "person.fill"))
                    }
                }
            }.resume()
        }
    }
    
}
