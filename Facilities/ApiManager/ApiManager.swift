//
//  ApiManager.swift
//  GetApiCall
//
//  Created by Azharuddin 1 on 11/05/23.
//
import Foundation
class APICallManager{
    func fetchData<T:Decodable>(url:URL, type: T.Type, completion: @escaping ( Result<T,Error> ) -> Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else  {
                completion(.failure(error ?? APIError.noData ))
                return
            }
                        
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(type, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch  {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

enum APIError: Error {
    case noData
}
