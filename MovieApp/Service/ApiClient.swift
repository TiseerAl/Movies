//
//  ApiClient.swift
//  Stocks App
//
//  Created by liram vahadi on 05/02/2021.
//

import Foundation

protocol ApiClient: AnyObject {
    
    var session: URLSession { get }
    func fetch<T: Codable>(with endPoint: String, completion: @escaping (Result<T>)->Void)
   
}

extension ApiClient{
    
    var session: URLSession{
        return URLSession(configuration: .default)
    }
    
    func fetch<T: Codable>(with endPoint: String, completion: @escaping (Result<T>)->Void){
        
        if InternetConnectionManager.isConnectedToNetwork(){
            
            guard let url = URL(string: ConstantValue.ApiValue.baseUrl + endPoint) else {
                completion(.failure(message: .invalidURL))
                return }
            
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            
            request.httpMethod = "GET"
           
            let task = session.dataTask(with: request){ [weak self] data, _ , error in
                DispatchQueue.main.async {
                    if error != nil{
                        print(error!)
                        completion(.failure(message: .generalMessage))
                    }
                    if let data = data{
                        do{
                            self?.dataString(data: data)
                            let jsonObject = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(value: jsonObject))
                        }catch{
                            print(error)
                            completion(.failure(message: .generalMessage))
                        }
                    }
                }
            }
            task.resume()
            
        }else{
            completion(.failure(message: .internerConnectionFailed))
        }
    }
    
    private func dataString(data: Data) {
        
        let string = String(data: data, encoding: .utf8)
        print(string)
        
    }
}
