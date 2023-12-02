//
//  File.swift
//  CloneNetflixFreeCodeCamp
//
//  Created by Irvan P. Saragi on 02/12/23.
//

import Foundation


struct Constans {
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError : Error{
    case failedtoGetData
}

class APICaller{
    static let shared = APICaller()
    
    
    func getTrandingMovies(completion : @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/trending/all/day?api_key=\(Constans.API_KEY)" ) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
