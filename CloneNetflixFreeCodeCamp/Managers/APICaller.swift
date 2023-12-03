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
    
    
    func getTrandingMovies(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/trending/movie/day?api_key=\(Constans.API_KEY)" ) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
    
    
    func getTrandingTvs(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/trending/tv/day?api_key=\(Constans.API_KEY)" ) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
    
    func getUpComingMovies(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/movie/upcoming?api_key=\(Constans.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                print(results)
            } catch{
                completion(.failure(APIError.failedtoGetData))            }
        }
        task.resume()
    }
    
    func getPopular(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/movie/popular?api_key=\(Constans.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/movie/top_rated?api_key=\(Constans.API_KEY)&language=en-US&page=1") else {return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
    
}
